#!/data/data/com.termux/files/usr/bin/bash

WORLD="${WORLD:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/worlds/default}"
MODS="${MODS:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/mods}"
WORLDMODS="$WORLD/worldmods"

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

[[ ! -L "$WORLDMODS" ]] || fail "Odmítám zapisovat přes symbolický odkaz worldmods: $WORLDMODS"
mkdir -p -- "$WORLDMODS" || fail "Nelze vytvořit adresář worldmods: $WORLDMODS"
stage_root="$(mktemp -d "$WORLD/.inject-mods.XXXXXX")" || fail "Nelze vytvořit dočasný adresář v: $WORLD"
active_target=""
active_backup=""

cleanup() {
    local status=$?
    local keep_stage=0
    trap - EXIT INT TERM

    if [[ -n "$active_backup" && ( -e "$active_backup" || -L "$active_backup" ) ]]; then
        if [[ ! -e "$active_target" && ! -L "$active_target" ]]; then
            if mv -- "$active_backup" "$active_target"; then
                active_backup=""
            else
                printf 'CHYBA: obnovení selhalo; záloha zůstala v %s\n' "$active_backup" >&2
                keep_stage=1
            fi
        fi
    fi

    if (( keep_stage == 0 )); then
        rm -rf -- "$stage_root"
    else
        printf 'Dočasný adresář se zálohou zůstává: %s\n' "$stage_root" >&2
    fi
    exit "$status"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

printf 'Kopíruji %d skupin modů do: %s\n' "${#groups[@]}" "$WORLDMODS"
while IFS= read -r group; do
    source_dir="$MODS/$group"
    target_dir="$WORLDMODS/$group"

    if [[ ! -d "$source_dir" ]]; then
        printf 'UPOZORNĚNÍ: skupina modů nebyla nalezena, přeskakuji: %s\n' "$source_dir" >&2
        continue
    fi

    staged_dir="$stage_root/$group.new"
    mkdir -p -- "$staged_dir" || fail "Nelze připravit skupinu modů: $group"
    cp -a -- "$source_dir/." "$staged_dir/" || fail "Kopírování skupiny modů selhalo: $group"

    if [[ -e "$target_dir" || -L "$target_dir" ]]; then
        active_target="$target_dir"
        active_backup="$stage_root/$group.previous"
        mv -- "$target_dir" "$active_backup" || fail "Nelze zachovat stávající skupinu modů: $group"
    fi

    if ! mv -- "$staged_dir" "$target_dir"; then
        if [[ -n "$active_backup" ]]; then
            mv -- "$active_backup" "$active_target" || fail "Instalace i návrat původní skupiny modů selhaly: $group"
            active_backup=""
            active_target=""
        fi
        fail "Nelze nainstalovat skupinu modů: $group"
    fi

    if [[ -n "$active_backup" ]]; then
        rm -rf -- "$active_backup" || fail "Nelze odstranit zálohu nahrazené skupiny modů: $group"
        active_backup=""
        active_target=""
    fi

    printf '  + %s\n' "$group"
done < <(printf '%s\n' "${!groups[@]}" | LC_ALL=C sort)

printf 'Hotovo.\n'
