![01]

Other Screenshots: [02]  [03]  [04]  [05]  [06]  [07]  [08]  [09]

Badge: [![ContentDB_en_icon]][ContentDB_en_link] [![DownloadsCDB_en_icon]][DownloadsCDB_en_link]

# 💵 [MINERTRADE][mod_minertrade]

[![luanti_icon]][luanti_link] It adds various types of money, Exchange Table, Dispensing Machines, and ATMs in stores.

## 📦 **Itens adicionados:**

### 💰 Types of Moneys:

| Types | Amount |
| :-- | --: |
| ```Minercoin```				| 01 minercash. (9^0 M$) |
| ```Minermoney Blue```		| 09 minercash. (9^1 M$) |
| ```Minermoney Green```	| 81 minercash. (9^2 M$) |
| ```Minermoney Yellow```	| 729 minercash. (9^3 M$) |
| ```Minermoney Orange```	| 6,561 minercash. (9^4 M$) |
| ```Minermoney Red```		| 59,049 minercash. (9^5 M$) |
| ```Minermoney Black```	| 531,441 minercash. (9^6 M$) |

### 🏦 Bank Items:

| Items | Descryption |
| :--: | :-- |
| ```Public ATM```  | Save your minercash (money type) in the ATM, and withdraw your minercash in other ATM in the shops scattered around the map. |
| ```Credit Card``` | Transfers between bank accounts, issuing a bank transfer receipt. |

### 🏙️ Store Items:

| Items | Descryption |
| :--: | :-- |
| ```Exchange Table (P2P)```	| It makes safe exchanges from player to player without the need to put your items on the ground. |
| ```Dispensing Machine``` 		| Sells your items, even if you are not online. |

## **Dependencies:**

| Mod Name | Dependency Type | Descryption |
| :--: | :--: | :-- |
| default | Mandatory |  Minetest Game Included. | 
| dye | Mandatory | Minetest Game Included. |
| [correio][mod_correio] | Optional |  Issues a letter to the owner of the ```Dispensing Machine``` when the machine needs the owner's intervention. | 
| [eurn][mod_eurn] | Optional | Select by vote who will be the president of the server with access to the public safe. | 
| [computing][mod_computing] | Optional | Add multiple devices, such as mobile phones and desktops, that allow you to access the bank remotely. | 

## **License:**

* [![license_code_icon]][license_code_link]
* [![license_media_icon]][license_media_link]

See more details in wiki: 
 
[![wiki_en_icon]][wiki_en_link] [![wiki_pt_icon]][wiki_pt_link]

## **Developers:**

* Lunovox Heavenfinder: [email](mailto:lunovox@disroot.org), [social web](https://bolha.us/@lunovox), [WebChat](https://cloud.disroot.org/call/9aa2t7ib), [xmpp](xmpp:lunovox@disroot.org?join), [audio conference](mumble:mumble.disroot.org), [more contacts](https://libreplanet.org/wiki/User:Lunovox)

## **Downloads:**

* [Stable Versions] : There are several versions in different stages of completion.  Usually recommended for servers because they are more secure.

* [Git Repository] : It is the version currently under construction.  There may be some stability if used on servers.  It is only recommended for testers and mod developers.

## **Internationalization of this Mod:**

This mod currently are configured to language:

* 🇬🇧/🇺🇸/🇨🇦/🇦🇺/🇮🇪 [English][lang_en_template] (Default/Template)
* 🇵🇹 [Portuguese (Generic)][lang_pt]
* 🇧🇷 [Português brasileiro][lang_pt_BR]

Translate this mod to **[🌐 Your Language][lang_translate]** ! 


## **Settings:**

In **minetest.conf** file:

You don't need to do any of these presets mentioned below to make this mod work. But it's worth knowing the configuration values ​​in case you want to directly change the ````minetest.conf```` file.

| Settings | Descryption |
| :-- | :-- |
| ````minertrade.debug = <boolean>```` 					| If show debug info of this mod. Only util to developers. Default: ````false````. | 
| ````minertrade.save_compressed = <boolean>```` 		| If enabled will save database bank in file '.db64', else in file '.tbl'. Default: ````true````. | 
| ````minertrade.bank.max_statements = <number>```` 	| Specifies the amount statement records to each player in databade bank.  Default: ````30````; Min: ````1````, Max: ````300````. | 
| ````minertrade.salary.enabled = <boolean>```` 		| Allows for daily distribution of Salary. Default: ````true````. | 
| ````minertrade.salary.value = <number>```` 			| Specifies the amount of salary paid daily.  Default: ````1````. | 
| ````minertrade.salary.intervalcheck = <number>```` 	| Specifies how many seconds the salary will be checked who still has to receive. Values below 5 can cause server lag. Default: ````60````. | 

[01]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot.png
[02]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot2.png
[03]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot3.png
[04]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot4.png
[05]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot5.png
[06]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot6.png
[07]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot7.png
[08]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot8.png
[09]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/screenshot9.png
[English]:https://en.wikipedia.org/wiki/GNU_Affero_General_Public_License
[Git Repository]:https://gitlab.com/luno_luanti/minertrade

[lang_translate]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/locale/README.md
[lang_en_template]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/locale/template.pot
[lang_pt]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/locale/tradelands.pt.po
[lang_pt_BR]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/locale/tradelands.pt_BR.po

[license_code_icon]:https://img.shields.io/static/v1?label=LICENSE%20CODE&message=GNU%20AGPL%20v3.0&color=yellow
[license_code_link]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/LICENSE_CODE
[license_media_icon]:https://img.shields.io/static/v1?label=LICENSE%20MEDIA&message=CC%20BY-SA-4.0&color=yellow
[license_media_link]:https://gitlab.com/luno_luanti/minertrade/-/raw/master/LICENSE_MEDIA

[locale/README.md]:https://gitlab.com/luno_luanti/minertrade/-/tree/master/locale?ref_type=heads
[mod_minertrade]:https://gitlab.com/luno_luanti/minertrade
[luanti_icon]:https://img.shields.io/static/v1?label=Minetest&message=Game&color=brightgreen
[luanti_link]:https://luanti.org

[mod_computing]:https://gitlab.com/luno_luanti/computing
[mod_correio]:https://gitlab.com/luno_luanti/correio
[mod_eurn]:https://gitlab.com/luno_luanti/e-urn
[mod_tradelands]:https://gitlab.com/luno_luanti/tradelands

[Portuguese]:https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License
[Stable Versions]:https://gitlab.com/luno_luanti/minertrade/-/tags

[wiki_en_icon]:https://img.shields.io/static/v1?label=GNU%20AGPL%20v3.0&message=EN&color=blue
[wiki_en_link]:https://en.wikipedia.org/wiki/GNU_Affero_General_Public_License
[wiki_pt_icon]:https://img.shields.io/static/v1?label=GNU%20AGPL%20v3.0&message=PT&color=blue
[wiki_pt_link]:https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License

[ContentDB_en_icon]:https://content.luanti.org/packages/Lunovox/minertrade/shields/title/
[ContentDB_en_link]:https://content.luanti.org/packages/Lunovox/minertrade/
[DownloadsCDB_en_icon]:https://content.luanti.org/packages/Lunovox/minertrade/shields/downloads/
[DownloadsCDB_en_link]:https://gitlab.com/luno_luanti/minertrade/-/tags


