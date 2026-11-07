minetest.register_craftitem("minertrade:paper_written", {
	description = modMinerTrade.translate("Paper Written"),
	--inventory_image = "bgf_scroll.png",
	--inventory_image = "default_paper.png", 
	--inventory_image = "[combine:16x32:0,0=default_cobble.png:0,16=default_wood.png", --ok
	--inventory_image = "default_paper.png^[fill:32x32:8,8:#20F02080", 
	inventory_image = "default_paper.png^[colorize:#888800:127", --ok
	--inventory_image = "bgf_scroll.png^[resize:16x16", --ok
	--inventory_image = "bgf_scroll.png^obj_minercoin.png", --ok

	groups = {paper = 1, printed = 1, not_in_creative_inventory = 1, flammable = 1},
	stack_max = 1,
	on_use = function(itemstack, user)
		local playername = user:get_player_name()
		local meta = itemstack:get_meta()
		local data = meta:to_table().fields
		local text = minetest.decode_base64(data.text)
		modMinerTrade.showPaperPrinted(playername, text)
	end,
})

default.register_craft_metadata_copy("default:paper", "minertrade:paper_written")

modMinerTrade.paperprinted = {
	
	max_title_size = 150, --[[
		Padão = 80
		
		OBSERVAÇÃO: 
			Segundo o google, o tamanho do metadado string 'description' (que descreve 
			o para que serve o item) é definido pela capacidade da memória RAM.
			Mas não se se isso é verídico ou não. 
			
			Por isso coloquei 150 em 'max_title_size', mas não sei sé é um tamanho bom.
	--]]
}


modMinerTrade.addPaperPrinted = function(player, txtItemDescription, txtPrinted)
	local playername = player:get_player_name()
	local data = {}
	--data.description = fields.title:sub(1, max_title_size)
	data.description = txtItemDescription:sub(1, modMinerTrade.paperprinted.max_title_size)
	--data.description = core.colorize("#00FF00", modMinerTrade.translate("PAPER WRITTEN") )
	--.."\n".." * "..data.title
	--data.description = txtItemDescription
	data.when = os.date() --os.date("%Y-%B-%d %Hh:%Mm:%Ss")
	data.text = minetest.encode_base64(txtPrinted:trim())
		
	local objPaperPrinted = ItemStack("minertrade:paper_written")
	objPaperPrinted:get_meta():from_table({ fields = data })
	
	local invPlayer = player:get_inventory()
	if invPlayer:room_for_item("main", objPaperPrinted) then-- verifica se compartimento de Recebimento de pagamento do vendedor tem espaço
		invPlayer:add_item("main", objPaperPrinted)
		minetest.chat_send_player(playername, 
			core.colorize("#00FF00", "["..modMinerTrade.translate("PRINTER").."]: ")
			..modMinerTrade.translate("Paper printing completed!")
		)
	else
		minetest.add_item(player:get_pos(), objPaperPrinted)
		minetest.chat_send_player(playername, 
			core.colorize("#00FF00", "["..modMinerTrade.translate("PRINTER").."]: ")
			..core.colorize("#FF0000", 
				modMinerTrade.translate("The printed paper was left on the floor because the '%s' inventory has no free space."):format(playername)
			)
		)
	end
	
end


modMinerTrade.showPaperPrinted = function(playername, text)
	--Fonte: 
		-- * https://minetest.gitlab.io/minetest/formspec/
		-- * https://minetest.gitlab.io/minetest/formspec/#hypertextxywhnametext
		-- * https://github.com/minetest/minetest/blob/master/doc/lua_api.md
	local myFormSpec = ""
	myFormSpec = myFormSpec
	--.."formspec_version[5.6.0]"
	.."formspec_version[6]"
	.."size[11,11,true]"
	.."no_prepend[]"
	.."bgcolor[#08080844;true]" --Padrão: #080808BB
	.."background[0,0;11,11;bgf_scroll.png]"
	--.."vertlabel[15.75,0.5;"..minetest.formspec_escape(modMinerTrade.translate("PRINTED PAPER")).."]"
	.."hypertext[1.00,1.00;9.25,7.50;myPage;"
	--..minetest.formspec_escape("<global margin=10 valign=0 color=#FF00FF hovercolor=#00FFFF size=12 font=normal halign=center >")
	.."<global valign=middle halign=left margin=10 background=#FFFFFF00 color=#000000 hovercolor=#00FF00 size=12 font=normal>"
	.."<tag name=action color=#FF0000 hovercolor=#00FF00 font=normal size=12>"
	--.."<tag name=item valign=top width=32 height=32>"
	..minetest.formspec_escape(text)
	.."]" -- Fim de hypertext[]
	minetest.show_formspec(playername, "paper_written", myFormSpec)
end


minetest.register_chatcommand("printsample", {
	params = "",
	description = "Imprime um papel no Inventário no jogador!.",
	privs = {server = true},
	func = function(playername, param)
		local txtPrintedSample = [[

<center>
	<img name=obj_piggy_bank.png float=center width=96 height=96>
	<style font=mono color=#FF0000 size=24><b>MINETEST BANK</b></style>
</center>



<item name=minertrade:minercoin valign=middle width=32 height=32> <big>Bem vindo, <b>%s</b>!</big>
Esse é um <action name=lnkMinercoin>Exemplo de Link</action> (não funcional) escrito em formato hyperlink.


























<center>
---------------------------------= FIM DA IMPRESSÃO =-------------------------------------
<bigger>=D</bigger>
Pressione <b>ESC</b> para sair desta tela!
</center>

]]
		local player = minetest.get_player_by_name(playername)
		modMinerTrade.addPaperPrinted(
			player, 
			core.colorize("#00FF00", modMinerTrade.translate("PAPER WRITTEN") )
			.."\n * Exemplo de Impressão em Papel.", 
			txtPrintedSample:format(playername)
		)
		
	end,
})


