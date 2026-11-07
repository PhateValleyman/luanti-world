#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT/inject_mods.sh"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/luanti-world-tests.XXXXXX")"

cleanup() {
    rm -rf -- "$TMP_ROOT"
}
trap cleanup EXIT

fail() {
    printf 'FAIL: %s\n' "$*" >&2
    exit 1
}

pass() {
    printf 'PASS: %s\n' "$*"
}

assert_no_stage_dirs() {
    local world="$1"
    local path
    for path in "$world"/.inject-mods.*; do
        [[ -e "$path" ]] && fail "temporary staging directory left behind: $path"
    done
    return 0
}

# Check syntax before testing script behavior.
bash -n "$SCRIPT"
[[ -x "$SCRIPT" ]] || fail "inject_mods.sh is not executable"
pass "shell syntax and executable bit"

# Exercise nested-mod discovery, explicit modpack paths, disabled mods, CRLF input, and clean replacement.
world="$TMP_ROOT/success world"
mods="$TMP_ROOT/success mods"
mkdir -p "$world/worldmods/pack" "$mods/pack/nested_mod" "$mods/direct"
printf 'old\n' > "$world/worldmods/pack/stale.txt"
printf 'nested mod\n' > "$mods/pack/nested_mod/init.lua"
printf 'pack marker\n' > "$mods/pack/.pack-marker"
printf 'direct mod\n' > "$mods/direct/init.lua"
printf 'creative_mode = true\r\nload_mod_nested_mod = true\r\nload_mod_direct = mods/direct\r\nload_mod_disabled = false\r\n' > "$world/world.mt"
WORLD="$world" MODS="$mods" bash "$SCRIPT" > "$TMP_ROOT/success.log"
[[ -f "$world/worldmods/pack/nested_mod/init.lua" ]] || fail "nested mod was not copied"
[[ -f "$world/worldmods/pack/.pack-marker" ]] || fail "hidden modpack file was not copied"
[[ "$(cat "$world/worldmods/direct/init.lua")" == 'direct mod' ]] || fail "explicit modpack was not copied"
[[ ! -e "$world/worldmods/pack/stale.txt" ]] || fail "stale file survived clean replacement"
[[ ! -e "$world/worldmods/disabled" ]] || fail "disabled mod was copied"
assert_no_stage_dirs "$world"
pass "enabled mod discovery, path handling, and replacement"

# Reject path traversal and empty/dot path components before changing the world.
for value in 'mods/..' 'mods/.' 'mods/'; do
    world="$TMP_ROOT/unsafe-${value//\//_}"
    mods="$world/mods"
    mkdir -p "$world/worldmods" "$mods"
    printf 'keep me\n' > "$world/sentinel.txt"
    printf 'load_mod_evil = %s\n' "$value" > "$world/world.mt"
    if WORLD="$world" MODS="$mods" bash "$SCRIPT" > "$TMP_ROOT/unsafe.log" 2>&1; then
        fail "unsafe path was accepted: $value"
    fi
    [[ -f "$world/sentinel.txt" ]] || fail "unsafe path damaged the world: $value"
done
pass "unsafe paths are rejected without modifying the world"

# Refuse a worldmods symlink so an unexpected external directory cannot be overwritten.
world="$TMP_ROOT/symlink/world"
mods="$TMP_ROOT/symlink/mods"
outside="$TMP_ROOT/symlink/outside"
mkdir -p "$world" "$mods/pack" "$outside"
printf 'keep me\n' > "$outside/sentinel.txt"
ln -s "$outside" "$world/worldmods"
printf 'load_mod_pack = mods/pack\n' > "$world/world.mt"
if WORLD="$world" MODS="$mods" bash "$SCRIPT" > "$TMP_ROOT/symlink.log" 2>&1; then
    fail "worldmods symlink was accepted"
fi
[[ -f "$outside/sentinel.txt" ]] || fail "symlink target was modified"
pass "worldmods symlinks are refused"

# Simulate a failed copy and verify the old installed directory remains untouched.
world="$TMP_ROOT/copy-failure/world"
mods="$TMP_ROOT/copy-failure/mods"
mock_bin="$TMP_ROOT/copy-failure/bin"
mkdir -p "$world/worldmods/pack" "$mods/pack" "$mock_bin"
printf 'old version\n' > "$world/worldmods/pack/version.txt"
printf 'new version\n' > "$mods/pack/version.txt"
printf 'load_mod_pack = mods/pack\n' > "$world/world.mt"
cat > "$mock_bin/cp" <<'EOF'
#!/bin/sh
exit 75
EOF
chmod +x "$mock_bin/cp"
if PATH="$mock_bin:$PATH" WORLD="$world" MODS="$mods" bash "$SCRIPT" > "$TMP_ROOT/copy-failure.log" 2>&1; then
    fail "copy failure was ignored"
fi
[[ "$(cat "$world/worldmods/pack/version.txt")" == 'old version' ]] || fail "copy failure replaced the old mod"
assert_no_stage_dirs "$world"
pass "copy failure preserves the previously installed mod"

# Fail the second move (installation) and allow the third move (rollback) to run normally.
world="$TMP_ROOT/move-failure/world"
mods="$TMP_ROOT/move-failure/mods"
mock_bin="$TMP_ROOT/move-failure/bin"
mkdir -p "$world/worldmods/pack" "$mods/pack" "$mock_bin"
printf 'old version\n' > "$world/worldmods/pack/version.txt"
printf 'new version\n' > "$mods/pack/version.txt"
printf 'load_mod_pack = mods/pack\n' > "$world/world.mt"
REAL_MV="$(command -v mv)"
export REAL_MV
export MV_COUNT_FILE="$TMP_ROOT/move-failure/mv-count"
cat > "$mock_bin/mv" <<'EOF'
#!/bin/sh
count=0
if [ -f "$MV_COUNT_FILE" ]; then
    read -r count < "$MV_COUNT_FILE"
fi
count=$((count + 1))
printf '%s\n' "$count" > "$MV_COUNT_FILE"
if [ "$count" -eq 2 ]; then
    exit 1
fi
exec "$REAL_MV" "$@"
EOF
chmod +x "$mock_bin/mv"
if PATH="$mock_bin:$PATH" WORLD="$world" MODS="$mods" bash "$SCRIPT" > "$TMP_ROOT/move-failure.log" 2>&1; then
    fail "install move failure was ignored"
fi
[[ "$(cat "$world/worldmods/pack/version.txt")" == 'old version' ]] || fail "failed install did not restore the old mod"
assert_no_stage_dirs "$world"
pass "install failure rolls back to the old mod"

# Ensure the repository world keeps creative mode enabled exactly once.
creative_count="$(grep -Ec '^[[:space:]]*creative_mode[[:space:]]*=' "$ROOT/world.mt" || true)"
[[ "$creative_count" == 1 ]] || fail "world.mt must contain exactly one creative_mode setting"
grep -Eq '^[[:space:]]*creative_mode[[:space:]]*=[[:space:]]*true([[:space:]]*(#.*)?)?$' "$ROOT/world.mt" || fail "creative_mode is not true in world.mt"
pass "world.mt has creative_mode enabled"

printf 'All inject_mods tests passed.\n'
