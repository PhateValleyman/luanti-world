# TRANSLATES
---------------------------------------------
To generate file '**template.pot**', did use terminal command:

```
cd minertrade
xgettext -n *.lua -L Lua --force-po --keyword=modMinerTrade.translate --from-code=UTF-8 -o ./locale/template.pot

```

To translate '**template.pot**' to your language use app poedit.:

---------------------------------------------
## Cria arquivo .po a partir de um arquivo de templante .pot

Sintaxe:
```
msginit --no-translator --no-wrap --locale=$toLANG.UTF-8 --output-file=minertrade.$toLANG.po --input=$POT
```

Example:
```
msginit --no-translator --no-wrap --locale=pt_BR.UTF-8 --output-file=./locale/minertrade.pt_BR.po --input=./locale/template.pot
```
---------------------------------------------
## Atualiza arquivo '.po' a partir de um arquivo de templante '.pot'.

Sintaxe:
```
msgmerge --sort-output --no-wrap --update --backup=off minertrade.$toLANG.po $POT
```

Example:
```
msgmerge --sort-output --no-wrap --update --backup=off ./locale/minertrade.pt_BR.po ./locale/template.pot
```
---------------------------------------------
## Install the PoEdit:

```
sudo apt-get install poedit
```

* Locales used: ca;cs;da;de;dv;eo;es;et;fr;hu;id;it;ja;jbo;kn;lt;ms;nb;nl;pl;pt;pt_BR;ro;ru;sl;sr_Cyrl;sv;sw;tr;uk

---------------------------------------------
## Exemple of enable the portuguese language in Luanti Engine:

Translate Sample: 

* "locale/minertrade.pt.po" to portuguese language.

To enable the translate to portuguese language, write "language = pt" in file "minetest.conf". Or write the command ```/set -n language pt``` in luanti console, and run again the luanti engine.

---------------------------------------------

## SUBMITTING YOUR TRANSLATION

If you understand any language other than English, please consider submitting your language translation '.po' file to '<lunovox@disroot.org>'!

