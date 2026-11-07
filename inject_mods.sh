#!/data/data/com.termux/files/usr/bin/bash

WORLD="/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/worlds/default"
MODS="/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/mods"
WORLDMODS="$WORLD/worldmods"

[ -f "$WORLD/world.mt" ] || { echo "CHYBA: chybí $WORLD/world.mt"; exit 1; }
[ -d "$MODS" ]           || { echo "CHYBA: chybí $MODS"; exit 1; }

mkdir -p "$WORLDMODS"

# groups[top_folder]=1  – kopírujeme vždy celou top-level složku z mods/
declare -A groups

while IFS= read -r line; do
    line="${line%$'\r'}"
    # přeskoč prázdné a komentáře
    [[ -z "$line" || "$line" == \#* ]] && continue

    # zachyť "load_mod_NAME = HODNOTA"
    [[ "$line" =~ ^load_mod_([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*(.+)$ ]] || continue
    name="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    # ořízni trailing whitespace
    value="${value%"${value##*[![:space:]]}"}"

    # vypnuté mody
    [ "$value" = "false" ] && continue

    # tvar "true" – hledej podle jména
    if [ "$value" = "true" ]; then
        found=""
        if [ -d "$MODS/$name" ]; then
            found="$name"
        else
            for d in "$MODS"/*/; do
                d="${d%/}"
                [ -d "$d/$name" ] && { found="$(basename "$d")"; break; }
            done
        fi
        if [ -z "$found" ]; then
            echo "  ! '$name' nenalezen"
        else
            groups["$found"]=1
        fi
        continue
    fi

    # tvar "mods/..." – relativní cesta pod Minetest/mods
    if [[ "$value" == mods/* ]]; then
        rest="${value#mods/}"
        top="${rest%%/*}"
        groups["$top"]=1
    else
        echo "  ? neznámý formát: load_mod_$name = $value"
    fi
done < "$WORLD/world.mt"

if [ ${#groups[@]} -eq 0 ]; then
    echo "Nenalezeny žádné zapnuté mody v world.mt."; exit 0
fi

echo "Kopíruji ${#groups[@]} položek do: $WORLDMODS"
for g in "${!groups[@]}"; do
    src="$MODS/$g"
    if [ ! -d "$src" ]; then
        echo "  ! '$g' neexistuje v $MODS – přeskakuji"
        continue
    fi
    echo "  + $g"
    rm -rf "$WORLDMODS/$g"
    cp -r "$src" "$WORLDMODS/$g"
done

echo
echo "Hotovo."
echo "Zkopírováno:"
ls -1 "$WORLDMODS"
