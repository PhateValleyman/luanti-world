# riderkoo_skin (Luanti mod)

## Účel
Mod nastavuje hráčům skin z Minecraftu (`riderkoo.png`, 64x64).

## Rozhodnutí / omezení
- Výchozí model Luanti (`character.b3d` z Minetest Game) používá starý formát 64x32.
- `textures/riderkoo_skin.png` = horní půlka skinu 64x32 + sloučené druhé vrstvy
  (bunda -> trup, rukáv -> pravá ruka, kalhoty -> pravá noha); levá ruka/noha se zrcadlí.
- `textures/riderkoo_skin_64x64.png` = původní skin (pro mody s 64x64 modelem, např. skinsdb).
- Vrstva "hat" na hlavě je ve formátu 64x32 už obsažena.

## Postup
- Zkopírovat složku `riderkoo_skin` do `~/.minetest/mods/` (nebo `~/.var/app/.../luanti/mods/`)
  a povolit ji ve světě (`load_mod_riderkoo_skin = true`).
- Setting `riderkoo_skin_player` omezí skin na jednoho hráče (prázdné = všichni).
