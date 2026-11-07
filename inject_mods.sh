#!/usr/bin/env bash
set -Eeuo pipefail

# Allow callers to override paths without editing this script.
WORLD="${MINETEST_WORLD:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/worlds/default}"
MODS="${MINETEST_MODS:-/storage/emulated/0/Android/data/net.minetest.minetest/files/Minetest/mods}"
WORLDMODS="$WORLD/worldmods"

if [[ ! -f "$WORLD/world.mt" ]]; then
	printf 'ERROR: Missing world configuration: %s\n' "$WORLD/world.mt" >&2
	exit 1
fi

if [[ ! -d "$MODS" ]]; then
	printf 'ERROR: Mod directory does not exist: %s\n' "$MODS" >&2
	exit 1
fi

mkdir -p "$WORLDMODS"

declare -A groups=()
shopt -s nullglob

while IFS= read -r line || [[ -n "$line" ]]; do
	line="${line%$'\r'}"

	# Ignore blank lines and comments.
	[[ "$line" =~ ^[[:space:]]*$ || "$line" =~ ^[[:space:]]*# ]] && continue

	# Read enabled mod entries from world.mt.
	[[ "$line" =~ ^[[:space:]]*load_mod_([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*(.*)$ ]] || continue
	name="${BASH_REMATCH[1]}"
	value="${BASH_REMATCH[2]}"
	value="${value#" ${value%%[![:space:]]*}"}"
	value="${value%"${value##*[![:space:]]}"}"

	# Skip explicitly disabled mods.
	[[ "$value" == "false" ]] && continue

	if [[ "$value" == "true" ]]; then
		found=""

		if [[ -d "$MODS/$name" && ! -L "$MODS/$name" ]]; then
			found="$name"
		else
			for directory in "$MODS"/*/; do
				directory="${directory%/}"
				if [[ -d "$directory/$name" ]]; then
					found="$(basename "$directory")"
					break
				fi
			done
		fi

		if [[ -z "$found" ]]; then
			printf 'WARN: Enabled mod not found: %s\n' "$name" >&2
		else
			groups["$found"]=1
		fi
		continue
	fi

	if [[ "$value" == mods/* ]]; then
		relative="${value#mods/}"
		top="${relative%%/*}"

		# Reject unsafe paths before using them as directory names.
		if [[ -z "$top" || "$top" == "." || "$top" == ".." || "$top" == *".."* ]]; then
			printf 'WARN: Unsafe mod path ignored: %s\n' "$value" >&2
			continue
		fi

		groups["$top"]=1
	else
		printf 'WARN: Unsupported mod path ignored: load_mod_%s = %s\n' "$name" "$value" >&2
	fi
done < "$WORLD/world.mt"

if (( ${#groups[@]} == 0 )); then
	printf 'INFO: No enabled mod entries found in %s/world.mt\n' "$WORLD"
	exit 0
fi

backup_root="$WORLD/.worldmods-backup/$(date +%Y%m%d-%H%M%S)-$$"
stage_dirs=()

# Remove only temporary staging directories created by this run.
cleanup() {
	local directory
	for directory in "${stage_dirs[@]}"; do
		[[ -n "$directory" && -d "$directory" ]] && rm -rf -- "$directory"
	done
}
trap cleanup EXIT

mkdir -p "$backup_root"

printf 'INFO: Preparing %d mod directories for %s\n' "${#groups[@]}" "$WORLDMODS"

for group in "${!groups[@]}"; do
	source_dir="$MODS/$group"
	destination="$WORLDMODS/$group"

	if [[ ! -d "$source_dir" || -L "$source_dir" ]]; then
		printf 'WARN: Source directory missing or is a symlink: %s\n' "$source_dir" >&2
		continue
	fi

	stage="$(mktemp -d "$WORLDMODS/.stage.XXXXXX")"
	stage_dirs+=("$stage")

	# Copy into a separate directory before touching the current mod.
	cp -a -- "$source_dir/." "$stage/"

	if [[ -e "$destination" || -L "$destination" ]]; then
		mkdir -p "$backup_root"
		if ! mv -- "$destination" "$backup_root/$group"; then
			printf 'ERROR: Could not back up existing mod: %s\n' "$destination" >&2
			exit 1
		fi
	fi

	if ! mv -- "$stage" "$destination"; then
		printf 'ERROR: Could not install staged mod: %s\n' "$destination" >&2
		if [[ -e "$backup_root/$group" || -L "$backup_root/$group" ]]; then
			mv -- "$backup_root/$group" "$destination"
		fi
		exit 1
	fi

	printf 'OK: %s\n' "$group"
done

printf 'INFO: Mod injection finished. Previous versions, if any, are in: %s\n' "$backup_root"
