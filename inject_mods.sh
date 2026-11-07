#!/data/data/com.termux/files/usr/bin/bash

WORLD="${WORLD:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/worlds/default}"
MODS="${MODS:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/mods}"
WORLDMODS="$WORLD/worldmods"

# Operation notes:
# Run only while no other process modifies this world; the symlink check rejects only a link already present.
# Previous groups are kept until the full batch installs; an install failure rolls back the batch if rollback operations succeed.
# If rollback itself fails, the script reports the error and preserves its temporary recovery directory under WORLD.

fail() {
    printf 'CHYBA: %s\n' "$*" >&2
    exit 1
}

is_safe_group() {
    [[ "$1" =~ ^[A-Za-z0-9_.-]+$ && "$1" != . && "$1" != .. ]]
}

[[ -f "$WORLD/world.mt" ]] || fail "Chybí soubor světa: $WORLD/world.mt"
[[ -d "$MODS" ]] || fail "Chybí adresář modů: $MODS"

# Collect enabled top-level mod or modpack directories before touching the world.
declare -A groups=()
while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%$'\r'}"
    [[ -z "$line" || "$line" == \#* ]] && continue
    [[ "$line" =~ ^load_mod_([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*(.+)$ ]] || continue

    name="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    value="${value%"${value##*[![:space:]]}"}"

    [[ "$value" == false ]] && continue

    if [[ "$value" == true ]]; then
        found=""
        if [[ -d "$MODS/$name" ]]; then
            found="$name"
        else
            for candidate in "$MODS"/*/; do
                [[ -d "$candidate" ]] || continue
                candidate="${candidate%/}"
                if [[ -d "$candidate/$name" ]]; then
                    found="${candidate##*/}"
                    break
                fi
            done
        fi

        if [[ -z "$found" ]]; then
            printf 'UPOZORNĚNÍ: zapnutý mod nebyl nalezen: %s\n' "$name" >&2
        elif is_safe_group "$found"; then
            groups["$found"]=1
        else
            fail "Nebezpečný název adresáře modu pro: $name"
        fi
        continue
    fi

    if [[ "$value" == mods/* ]]; then
        rest="${value#mods/}"
        top="${rest%%/*}"
        is_safe_group "$top" || fail "Nebezpečná cesta modpacku v world.mt: $value"
        groups["$top"]=1
    else
        printf 'UPOZORNĚNÍ: nepodporované nastavení load_mod: %s\n' "$name" >&2
    fi
done < "$WORLD/world.mt"

if (( ${#groups[@]} == 0 )); then
    printf 'V world.mt nebyly nalezeny žádné zapnuté adresáře modů.\n'
    exit 0
fi

# This refuses a pre-existing symlink; the world directory must remain single-writer during execution.
[[ ! -L "$WORLDMODS" ]] || fail "Odmítám zapisovat přes symbolický odkaz worldmods: $WORLDMODS"
mkdir -p -- "$WORLDMODS" || fail "Nelze vytvořit adresář worldmods: $WORLDMODS"
stage_root="$(mktemp -d "$WORLD/.inject-mods.XXXXXX")" || fail "Nelze vytvořit dočasný adresář v: $WORLD"

ordered_groups=()
while IFS= read -r group; do
    ordered_groups+=("$group")
done < <(printf '%s\n' "${!groups[@]}" | LC_ALL=C sort)

declare -a transaction_groups=()
declare -a transaction_had_previous=()
commit_complete=0

rollback_transaction() {
    local failed=0
    local index group had_previous target_dir backup_dir

    for ((index = ${#transaction_groups[@]} - 1; index >= 0; index--)); do
        group="${transaction_groups[index]}"
        had_previous="${transaction_had_previous[index]}"
        target_dir="$WORLDMODS/$group"
        backup_dir="$stage_root/$group.previous"

        if (( had_previous )); then
            if [[ -e "$backup_dir" || -L "$backup_dir" ]]; then
                if [[ -e "$target_dir" || -L "$target_dir" ]]; then
                    if ! rm -rf -- "$target_dir"; then
                        printf 'CHYBA: nelze odstranit novou verzi při návratu: %s\n' "$group" >&2
                        failed=1
                        continue
                    fi
                fi
                if ! mv -- "$backup_dir" "$target_dir"; then
                    printf 'CHYBA: nelze obnovit původní skupinu: %s\n' "$group" >&2
                    failed=1
                fi
            elif [[ ! -e "$target_dir" && ! -L "$target_dir" ]]; then
                printf 'CHYBA: chybí původní skupina i její záloha: %s\n' "$group" >&2
                failed=1
            fi
        elif [[ -e "$target_dir" || -L "$target_dir" ]]; then
            if ! rm -rf -- "$target_dir"; then
                printf 'CHYBA: nelze odstranit novou skupinu při návratu: %s\n' "$group" >&2
                failed=1
            fi
        fi
    done

    return "$failed"
}

cleanup() {
    local status=$?
    local keep_stage=0
    trap - EXIT INT TERM

    if (( status != 0 && commit_complete == 0 )); then
        rollback_transaction || keep_stage=1
    fi

    if (( keep_stage == 0 )); then
        if ! rm -rf -- "$stage_root"; then
            printf 'CHYBA: nelze odstranit dočasná data: %s\n' "$stage_root" >&2
            keep_stage=1
            (( status == 0 )) && status=1
        fi
    fi

    if (( keep_stage )); then
        printf 'Obnovovací data ponechána v: %s\n' "$stage_root" >&2
    fi
    exit "$status"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# Stage every source before replacing any installed mod group.
for group in "${ordered_groups[@]}"; do
    source_dir="$MODS/$group"
    [[ -d "$source_dir" ]] || fail "Zdrojová skupina modů chybí: $source_dir"

    staged_dir="$stage_root/$group.new"
    mkdir -p -- "$staged_dir" || fail "Nelze připravit skupinu modů: $group"
    cp -a -- "$source_dir/." "$staged_dir/" || fail "Kopírování skupiny modů selhalo: $group"
done

printf 'Kopíruji %d skupin modů do: %s\n' "${#ordered_groups[@]}" "$WORLDMODS"
for group in "${ordered_groups[@]}"; do
    target_dir="$WORLDMODS/$group"
    backup_dir="$stage_root/$group.previous"
    staged_dir="$stage_root/$group.new"
    had_previous=0

    if [[ -e "$target_dir" || -L "$target_dir" ]]; then
        had_previous=1
    fi
    transaction_groups+=("$group")
    transaction_had_previous+=("$had_previous")

    if (( had_previous )); then
        mv -- "$target_dir" "$backup_dir" || fail "Nelze zachovat stávající skupinu modů: $group"
    fi

    mv -- "$staged_dir" "$target_dir" || fail "Nelze nainstalovat skupinu modů: $group"
    printf '  + %s\n' "$group"
done

commit_complete=1
printf 'Hotovo.\n'
