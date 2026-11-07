core.register_privilege("developer",  {
   description=modMinerTrade.translate("Can access evolving ATM functions."), 
   give_to_singleplayer=false,
})

modMinerTrade.getUrlDatabase = function()
	--Extensao '.tbl' ou '.db'
	local extension = ""
	if modMinerTrade.save_compressed then
		extension = ".db64"
	else
		extension = ".tbl"
	end
	return core.get_worldpath().."/minertrade"..extension
end

modMinerTrade.getDelayToUse = function()
	if modMinerTrade.delay_to_use == nil then
		modMinerTrade.delay_to_use = core.settings:get("minertrade.delay_to_use")
		if modMinerTrade.delay_to_use == nil 
			or type(tonumber(modMinerTrade.delay_to_use)) ~= "number" 
			or tonumber(modMinerTrade.delay_to_use) < 1
		then
			modMinerTrade.delay_to_use = 300 -- 300 = 5 minutes
			core.settings:set("minertrade.delay_to_use", modMinerTrade.delay_to_use)
		end
	end
	return tonumber(modMinerTrade.delay_to_use)
end

modMinerTrade.canInteract = function(playername)
	--local clickername = clicker:get_player_name()
	if core.get_player_privs(playername).mayor 
	   or core.get_player_privs(playername).protection_bypass 
	   or core.get_player_privs(playername).server 
	then
		return true
	end
	return false
end

modMinerTrade.isExistAcount = function(playername)
	if type(playername)=="string" 
		and playername~="" 
		and type(modMinerTrade)=="table"
		and type(modMinerTrade.bank)=="table"
		and type(modMinerTrade.bank.player)=="table"
		and type(modMinerTrade.bank.player[playername])=="table"
	then
		return true
	end
	return false
end

modMinerTrade.createAcount = function(playername)
	if type(modMinerTrade)~="table" then
		modMinerTrade = { }
	end
	if type(modMinerTrade.bank)~="table" then
		modMinerTrade.bank = {
			accounts = 0,
			last_pay = 0,
		}
	end
	if type(modMinerTrade.bank.accounts)~="number" then
		modMinerTrade.bank.accounts = 0
	end
	if type(modMinerTrade.bank.last_pay)~="number" then
		modMinerTrade.bank.last_pay = 0
	end
	if type(modMinerTrade.bank.player)~="table" then
		modMinerTrade.bank.player = { }
	end
	if type(modMinerTrade.bank.player[playername])~="table" then
		modMinerTrade.bank.player[playername] = { 
			account_created = os.date("%Y-%B-%d %Hh:%Mm:%Ss"),
			balance = 0,
			total_transactions = 0,
			statement = { }
		}
		--modMinerTrade.bank.player[playername].account_created
		modMinerTrade.bank.accounts = modMinerTrade.bank.accounts + 1
		modMinerTrade.doBankSave()
		return true
	else
		return false
	end
end

modMinerTrade.getBalance = function(playername)
	local balance = 0
	if modMinerTrade.isExistAcount(playername) then
		balance = tonumber(modMinerTrade.bank.player[playername].balance)
	end
	return balance
end

modMinerTrade.addBalance = function(playername, value)
	if value ~= nil and type(value) == "number" and value ~= 0 then
		if modMinerTrade.isExistAcount(playername) then
			modMinerTrade.bank.player[playername].balance = modMinerTrade.bank.player[playername].balance + value
			return true
		end
	end
	return false
end

modMinerTrade.getMaxStatements = function() --MÁXIMO DE EXTRATOS ARMAZENADOS.
	local maxStatements = core.settings:get("minertrade.bank.max_statements")
	if maxStatements == nil 
		or type(tonumber(maxStatements)) ~= "number" 
		or tonumber(maxStatements) < 1 --Min
		or tonumber(maxStatements) > 300 --Max
	then
		maxStatements = 30
		core.settings:set("minertrade.bank.max_statements", tostring(maxStatements))
	end
	return tonumber(maxStatements)
end

modMinerTrade.getTotalTransactions = function(playername) --TOTAL DE MOVIMENTAÇOES FINANCEIRAS DESDE ACRIACAO DA CONTA.
	if modMinerTrade.isExistAcount(playername) then
		return modMinerTrade.bank.player[playername].total_transactions or 0
	end
	return 0
end

modMinerTrade.addStatement = function(playername, value, description)
	if value ~= nil and type(value) == "number" and value ~= 0 then
		if modMinerTrade.isExistAcount(playername) then
			local myStatement = modMinerTrade.getStatement(playername)
			local totalTransactions = modMinerTrade.getTotalTransactions(playername)
			if myStatement ~= nil
				and type(myStatement)
				and #myStatement >= 1
			then
				local maxStatements = modMinerTrade.getMaxStatements()
				if #myStatement >= maxStatements then
					local toDelete = (#myStatement - maxStatements) + 1
					for i = toDelete, 1, -1 do 
						table.remove (myStatement, i)
					end
				end
			end
			table.insert(
				myStatement,
				{
					when = os.date("%Y-%b-%d %H:%M:%S"),
					value = value,
					description = description,
				}
			)
			modMinerTrade.bank.player[playername].total_transactions = totalTransactions + 1
			modMinerTrade.bank.player[playername].statement = myStatement
			return true
		end
	end
	return false
end

modMinerTrade.getStatement = function(playername)
	if playername ~= nil and type(playername) == "string" and playername ~= "" then
		if modMinerTrade.isExistAcount(playername) then
			return modMinerTrade.bank.player[playername].statement
		end
	end
end

modMinerTrade.getSalt_Hash = function()
	if modMinerTrade.bank.salt_hash == nil then
		modMinerTrade.bank.salt_hash = core.encode_base64("SALT_HASH: "..os.date("%Y-%B-%d %Hh:%Mm:%Ss"))
	end
	return modMinerTrade.bank.salt_hash
end

modMinerTrade.addTransferProof_v2 = function(player, accountname, txtBeneficiary, txtValue, txtReason)
	local playername = player:get_player_name()
	local when = os.date("%Y-%B-%d %Hh:%Mm:%Ss")
	local title = modMinerTrade.translate("TRANSFER PROOF")
	local itemDescription = core.colorize("#00FF00", title)
		.."\n"..modMinerTrade.translate("Reason: %s"):format(
			txtReason:sub(1, modMinerTrade.paperprinted.max_title_size)
		)

	local docData = ""
		.."\n"..modMinerTrade.translate("Document Type")..": "..modMinerTrade.translate("TRANSFER PROOF")
		.."\n"..modMinerTrade.translate("Responsible Player")..": "..playername
		.."\n"..modMinerTrade.translate("Account Holder")..": "..accountname
		.."\n"..modMinerTrade.translate("Beneficiary")..": "..txtBeneficiary
		.."\n"..modMinerTrade.translate("When")..": "..when
		.."\n"..modMinerTrade.translate("Value")..": "..("%02d"):format(tonumber(txtValue)).." minercash"
		.."\n"..modMinerTrade.translate("Transfer Reason")..": "..txtReason
	
	local Auth = core.get_password_hash(
		modMinerTrade.getSalt_Hash(), 
		core.encode_base64(docData:trim())
	)
	
	local htmlBody = [[
<global valign=middle halign=left margin=10 background=#FFFFFF00 color=#000000 hovercolor=#00FF00 size=12 font=mono>
<tag name=action color=#FF0000 hovercolor=#00FF00 font=mono size=12>
<center>
	<img name=obj_piggy_bank.png float=center width=96 height=96>
	<style font=mono color=#FF0000 size=24><b><minetest_bank/></b></style>
	<transfer_proof/>
</center>

<doc_data/>

<center>
-------------= AUTHENTICATION HASH =--------------
<center><transfer_auth/></center>
--------------------------------------------------
<exit_message/>
</center>
]]
	--[[  ]]
	htmlBody = htmlBody:gsub('<minetest_bank/>', core.formspec_escape(modMinerTrade.translate("MINETEST BANK")))
	htmlBody = htmlBody:gsub('AUTHENTICATION HASH', core.formspec_escape(modMinerTrade.translate("AUTHENTICATION HASH")))
	htmlBody = htmlBody:gsub('<exit_message/>', core.formspec_escape(modMinerTrade.translate("Press <b>ESC</b> to exit this screen!")))
	htmlBody = htmlBody:gsub('<transfer_proof/>', core.formspec_escape(title))
	htmlBody = htmlBody:gsub('<doc_data/>', core.formspec_escape(docData))
	htmlBody = htmlBody:gsub('<transfer_auth/>', core.formspec_escape(Auth))
	--]]
	
	modMinerTrade.addPaperPrinted(player, itemDescription, htmlBody)
		
end

modMinerTrade.addTransferProof_v1 = function(player, accountname, txtBeneficiary, txtValue, txtReason)
	local playername = player:get_player_name()
	local objProof = modMinerTrade.getProofStack(playername, accountname, txtBeneficiary, txtValue, txtReason)
	local invPlayer = player:get_inventory()
	if invPlayer:room_for_item("main", objProof) then-- verifica se compartimento de Recebimento de pagamento do vendedor tem espaço
		invPlayer:add_item("main", objProof)
		core.chat_send_player(playername, 
			core.colorize("#00FF00", "["..modMinerTrade.translate("ATM").."]: ")
			..modMinerTrade.translate("Transfer successful!")
		)
	else
		core.add_item(player:get_pos(), objProof)
		core.chat_send_player(playername, 
			core.colorize("#00FF00", "["..modMinerTrade.translate("ATM").."]: ")
			..core.colorize("#FF0000", 
				modMinerTrade.translate("The Transfer Proof was left on the floor because '%s' inventory has no free space."):format(playername)
			)
		)
	end
end

modMinerTrade.getProofStack = function(playername, accountname, txtBeneficiary, txtValue, txtReason)
	local player = core.get_player_by_name(playername)
	if player ~= nil and player:is_player() then
		local lpp = 14 -- Lines per book's page
		local max_text_size = 10000
		local max_title_size = 80
		local short_title_size = 35
		
		local objProof = ItemStack("default:book_written")
		--local data = objProof:get_meta():to_table().fields
		local data = {}
		--data.title = fields.title:sub(1, max_title_size)
		data.title = modMinerTrade.translate("TRANSFER PROOF"):sub(1, max_title_size)
		data.owner = "MINETEST BANK"
		data.description = core.colorize("#00FF00", data.title)
		.."\n"..modMinerTrade.translate("Reason: %s"):format(txtReason)
		--.."\n"..modMinerTrade.translate("Printed by %s"):format(playername)
		local when = os.date("%Y-%B-%d %Hh:%Mm:%Ss")
		local myDocument = ""
		.."\n"..modMinerTrade.translate("Document Type")..": "..modMinerTrade.translate("TRANSFER PROOF")
		.."\n"..modMinerTrade.translate("Responsible Player")..": "..playername
		.."\n"..modMinerTrade.translate("Account Holder")..": "..accountname
		.."\n"..modMinerTrade.translate("Beneficiary")..": "..txtBeneficiary
		.."\n"..modMinerTrade.translate("When")..": "..when
		.."\n"..modMinerTrade.translate("Value")..": "..txtValue.." minercash"
		.."\n"..modMinerTrade.translate("Transfer Reason")..": "..txtReason
		
		local Auth = core.get_password_hash(
			modMinerTrade.getSalt_Hash(), 
			core.encode_base64(myDocument:trim())
		)
		data.text = ""
		.."\n"..myDocument:trim()
		.."\n----------------------------------"
		.."\n"..Auth
		
		data.text = data.text:sub(1, max_text_size)
		data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)
		objProof:get_meta():from_table({ fields = data })
		return objProof
	end
end

modMinerTrade.checkValidStack = function(stack)
	local cashtypes= modMinerTrade.getCashTypes()
	for i, item in pairs(cashtypes) do
		if item == stack:get_name() then
			return stack:get_count()
		end
	end
	return 0
end

modMinerTrade.getValueStack = function(stack)
	local cashtypes= modMinerTrade.getCashTypes()
	for i, item in pairs(cashtypes) do
		if item == stack:get_name() then
			local amount = stack:get_count()
			return  (9 ^ (i - 1)) * amount
		end
	end
	return 0
end

modMinerTrade.showAccountBank = {
	--modMinerTrade.showAccountBank.inAtm(playername, accountname)
	inAtm = function(playername, accountname)
	   if modMinerTrade.isExistAcount(accountname) then
   		modMinerTrade.bank.player[playername].focused_accountname = accountname
   		modMinerTrade.bank.player[playername].focused_accountmode = "atm"
   		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
   		modMinerTrade.showAccountBank.frmMain(playername)
		end
	end,
	--modMinerTrade.showAccountBank.inCreditCard(playername, accountname)
	inCreditCard = function(playername, accountname)
		if modMinerTrade.isExistAcount(accountname) then
   		modMinerTrade.bank.player[playername].focused_accountname = accountname
   		modMinerTrade.bank.player[playername].focused_accountmode = "online"
   		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
   		modMinerTrade.showAccountBank.frmMain(playername)
		end
	end,
	--[[  ]]
	inPublicAccess = function(playername) --
	   local accountname = "THE GOVERNMENT"
	   if not modMinerTrade.isExistAcount(accountname) then
         modMinerTrade.createAcount(accountname)
      end
		modMinerTrade.bank.player[playername].focused_accountname = accountname
		modMinerTrade.bank.player[playername].focused_accountmode = "public_access"
		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
		modMinerTrade.showAccountBank.frmMain(playername)
	end,
	--]]
	frmMain = function(playername) --FORMULÁRIO: PRINCIPAL / RAIZ
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		local accountmode = modMinerTrade.bank.player[playername].focused_accountmode
		local formspec = "size[16,10]"
			.."bgcolor[#636D7688;false]"
			--.."bgcolor[#636D76FF;false]"
			--..default.gui_bg
			--..default.gui_bg_img
			--..default.gui_slots
			
			--.."background[5.0,-0.25;10,10;default_steel_block.png^text_atm_front.png]"
			..        "box[0.00,0.10;5.50,9.5;#000000]"
			..     "button[0.25,0.50;5.00,0.5;btnBalance;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BALANCE"))).."]"
			..     "button[0.25,1.25;5.00,0.5;btnStatement;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("STATEMENT"))).."]"
		if type(accountmode) == "string" and ( --Aacesso público à contas públicas não tem transferência.
		      accountmode == "atm"
		      or accountmode == "online"
		      or (
		         accountmode == "public_access" and (
      		      core.get_player_privs(playername).mayor
      		      or (core.global_exists("modEUrn") and modEUrn.getPresidentName()==playername)
      		   )
   		   )
		   )
		then
			formspec = formspec
			   ..     "button[0.25,3.50;5.00,0.5;btnTransfers;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("TRANSFERS"))).."]"
		end
		if type(accountmode) == "string" and (accountmode == "atm" or accountmode == "public_access") then
			formspec = formspec
				..     "button[0.25,2.00;5.00,0.5;btnDeposits;"..core.formspec_escape(core.colorize("#FFFFF", modMinerTrade.translate("DEPOSITS"))).."]"
		end
		if type(accountmode) == "string" and accountmode == "atm" 
		then
			formspec = formspec
				..     "button[0.25,2.75;5.00,0.5;btnWithdrawals;"..core.formspec_escape(core.colorize("#FFFFF", modMinerTrade.translate("WITHDRAWALS"))).."]" -- [DINHEIRO E CHECK]
		end
		if core.get_player_privs(playername).developer then
			formspec = formspec
				..     "button[0.25,5.00;5.00,0.5;btnCreditCard;"..core.formspec_escape(core.colorize("#888888", modMinerTrade.translate("CREDIT CARD"))).."]" -- [EXPEDIR E MUDAR SENHA]
				..     "button[0.25,4.25;5.00,0.5;btnLoans;"..core.formspec_escape(core.colorize("#888888", modMinerTrade.translate("LOANS"))).."]" --Emprestimos
				..     "button[0.25,5.75;5.00,0.5;btnLottery;"..core.formspec_escape(core.colorize("#888888", modMinerTrade.translate("LOTTERY"))).."]" --Lotérica
				..     "button[0.25,6.50;5.00,0.5;btnSetings;"..core.formspec_escape(core.colorize("#888888", modMinerTrade.translate("SETTINGS"))).."]" --Se quer ou não uma senha, se quer receber uma carta quando houver uma nova movimentacao.
		end
		if type(accountmode) == "string" and accountmode ~= "public_access" 
		   
		then
		   formspec = formspec
			   .."button[0.25,6.50;5.00,0.5;btnPublicAccess;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("THE GOVERNMENT"))).."]"
		end
		formspec = formspec
			.."button_exit[0.25,7.25;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
			
			--..     "box[6.0,0.25;9.5,9.5;#000000]"
			.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		core.show_formspec(playername, "frmAtmMain", formspec)
	end,
	frmBalance = function(playername) --FORMULÁRIO: SALDO
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		local account_created = ""
		local msgBalance = ""
		if modMinerTrade.isExistAcount(accountname) then
			msgBalance = modMinerTrade.translate("You have %02d minercash."):format(modMinerTrade.getBalance(accountname))
			account_created = modMinerTrade.bank.player[accountname].account_created
		else
			msgBalance = modMinerTrade.translate("Player '%s' is not an account holder of this bank."):format(accountname)
			account_created = "----/--/-- --:--:--"
		end
		
		--local tblStatements = modMinerTrade.getStatement(accountname)
		local totalTransactions = modMinerTrade.getTotalTransactions(accountname)
		
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		..       "box[6.0,0.25;9.5,9.5;#00000088]"
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		
		..  "textarea[6.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("NAME OF BANKING ACCOUNT HOLDER")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", accountname:upper())).."]"
		
		..  "textarea[6.75,2.50;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("ACCOUNT CREATED")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", account_created)).."]"
		
		..  "textarea[6.75,4.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("FINANCIAL TRANSACTIONS")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", ("%02d"):format(totalTransactions).." transactions.")).."]"
		
		..  "textarea[6.75,5.50;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BALANCES")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgBalance)).."]"
		
		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
		core.show_formspec(
			playername, 
			"frmAtmBalance", 
			formspec
		)
	end,
	frmStatement = function(playername, selStatement) --FORMULÁRIO: EXTRATO
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		local formspec = "size[16,10]"
		.."bgcolor[#636D7644;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		--.."bgcolor[#636D76FF;false]"
		--.."background[-0.25,-0.25;10,11;safe_inside.png]"
		--.."button[0,0.0;4,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		--.."button_exit[0,3.0;4,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		..       "box[6.0,0.25;9.5,9.5;#00000088]"
		--.."background[5.0,0.25;9.5,9.5;text_atm_front.png]"
		
		local msgStatement = modMinerTrade.translate("Select a bank statement to view transaction details!")
		local isAccount = modMinerTrade.isExistAcount(accountname)
		if isAccount then
			formspec = formspec
			..   "label[6.25,0.50;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("STATEMENT")..":")).."]"
			--..   "label[5.25,2.50;"..core.formspec_escape(core.colorize("#00FFFF", msgStatement)).."]"
			--"textarea[5.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("STATEMENT")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgStatement)).."]"
			
			local listStatement = modMinerTrade.getStatement(accountname)
			local plusStatement = "#888,"..modMinerTrade.translate("N°")..","..modMinerTrade.translate("WHEN")..","..modMinerTrade.translate("VALUE")
			
			for i, oneStatement in ipairs(listStatement) do
				local sign = ""
				if oneStatement.value >= 1 then
					sign = "+"
				end
				--local line = oneStatement.when.." | "..sign..oneStatement.value.." minercash."
				local line = "#FFF,"
					..(("%03d"):format(i))..","
					..core.formspec_escape(oneStatement.when)
					..","
					..core.formspec_escape(sign..("%02d"):format(oneStatement.value).." MT$.")
				if plusStatement == "" then
					plusStatement = line
				else
					plusStatement = plusStatement..","..line
				end
			end
			--[[  ]]
			local value = modMinerTrade.getBalance(accountname)
			if value ~= nil then
				local sign = ""
				if value >= 1 then
					sign = "+"
				end
				plusStatement = plusStatement..",#FFFF00,,"
				--..core.formspec_escape(os.date("%Y-%B-%d %Hh:%Mm:%Ss"))
				..core.formspec_escape(modMinerTrade.translate("TOTAL")..": ")
				..core.formspec_escape(sign..("%02d"):format(value).." minercash.")
				..","
			end
			--]]

			local mySel = ""
			if selStatement ~= nil and type(selStatement)=="number" and selStatement >= 2 and selStatement <= #listStatement+1 then
				mySel = selStatement
				msgStatement = dump(listStatement[selStatement-1].description)
			end
			formspec = formspec
			.."         style[fldStatement;bgcolor=red;textcolor=yellow;border=true]"
			.."  tablecolumns[color;text;text;text]"
			..         "table[6.25,1.00;9.0,6.75;fldStatement;"..plusStatement..";"..mySel.."]"
			--..    "textlist[5.25,1.00;9.0,6.0;fldStatement;"..plusStatement..";"..mySel.."]"
			--.."tablecolumns[cell1,opt1_a,opt2_a;cell2,opt1_b,opt2_b;type_c,opt1_c,opt2_c]"
			--.."tableoptions[opt1;opt2;opt3]"
		else
			msgStatement = modMinerTrade.translate("Player '%s' is not an account holder of this bank."):format(accountname)
		end

		formspec = formspec
		.."textarea[6.75,8.50;9.0,1.5;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("TRANSACTION DETAILS")..":"))..";"
			..core.formspec_escape(core.colorize("#00FFFF", msgStatement))
		.."]"
		
		
		
		core.show_formspec(
			playername, 
			"frmAtmStatement", 
			formspec
		)
	end,
	frmWithdrawals = function(playername) --FORMULÁRIO: FORMAS DE SAQUE
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		..       "box[6.0,0.25;9.5,9.5;#000000CC]"
		
		..   "label[6.75,0.75;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("SELECT BANK WITHDRAWAL METHOD")..":")).."]"
		--..  "textarea[5.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BALANCES")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgBalance)).."]"
		--..  "button[6.25,1.50;1.00,1.00;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		--.."style_type[image_button;bgcolor=#00000000;border=false]"
		--.."style[btnMinercoin;bgimg=sbl_save.png;bgimg_hovered=sbl_save_pressed.png;bgimg_pressed=sbl_save_pressed.png;border=false]"
		..   "label[9.25,3.25;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("MINERCASH"))).."]"
		.."tooltip[btnMinercoin;"..core.formspec_escape(modMinerTrade.translate("Withdrawals in minercash."))..";#CCCC0088;#000000]"
		.."image_button[7.25,2.50;2.00,2.00;obj_minercoin.png;btnGiveCash;]"
		
		..   "label[9.25,5.75;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BANK CHECK"))).."]"
		.."tooltip[btnMinercoin;"..core.formspec_escape(modMinerTrade.translate("Withdrawals in bank check."))..";#CCCC0088;#000000]"
		.."image_button[7.25,5.00;2.00,2.00;obj_bank_check.png;btnGiveCheck;]"
		
		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
		core.show_formspec(playername, "frmAtmWithdrawals", formspec)
	end,
	frmGiveCash = function(playername, txtValue, msgDetails) --FORMULÁRIO: SAQUE EM DINHEIRO
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		modMinerTrade.debug("modMinerTrade.showAccountBank.frmGiveCash() >>> playername = "..playername.." | txtValue = "..dump(txtValue).." | msgDetails = "..dump(msgDetails))
		
		local msgBalance = ""
		if modMinerTrade.isExistAcount(accountname) then
			msgBalance = modMinerTrade.translate("You have %02d minercash."):format(modMinerTrade.getBalance(accountname))
		else
			msgBalance = modMinerTrade.translate("Player '%s' is not an account holder of this bank."):format(accountname)
		end
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnWithdrawals;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		..       "box[6.0,0.25;9.5,9.5;#000000CC]"
		
		..  "textarea[6.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BALANCES")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgBalance)).."]"
		
		if modMinerTrade.isExistAcount(accountname) then
			if txtValue == nil or txtValue == "" then
				txtValue = "1"
			end
			if msgDetails == nil or msgDetails == "" then
				msgDetails = modMinerTrade.translate("Write the value that want to withdrawal!")
			end
			formspec = formspec
			--..   "label[5.25,0.50;"..core.formspec_escape(core.colorize("#00FFFF", "WITHDRAWAL IN MINERCASH:")).."]"
			.."field[7.00,3.50;3.00,0.50;txtValue;"
				..core.formspec_escape(
					core.colorize(
						"#00FFFF", 
						modMinerTrade.translate("VALUE")..":"
					)
				)..";"
				..core.formspec_escape(txtValue)
			.."]"
			..  "button[9.85,3.00;4.00,1.00;btnAtmGive;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("WITHDRAWAL"))).."]"
	
			.."textarea[6.75,8.50;9.0,1.5;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("DETAILS")..":"))..";"
				..core.formspec_escape(core.colorize("#00FFFF", msgDetails))
			.."]"
		end
		core.show_formspec(playername, "frmAtmGiveCash", formspec)
	end,
	frmDeposits = function(playername) --FORMULÁRIO: DEPÓSITOS
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		-- playername = player:get_player_name()
		local newInv = core.create_detached_inventory("deposits_"..playername, { 
	
			-- Called when a player wants to move items inside the inventory
			allow_move = function(inv, from_list, from_index, to_list, to_index, count, player) 
				--return count
				return 0
			end,
	
			-- Called when a player wants to put items into the inventory
			allow_put = function(inv, listname, index, stack, player) 
				if modMinerTrade.checkValidStack(stack) >= 1 then
					return stack:get_count()
				else
					return 0
				end
			end,
	
			-- Called when a player wants to take items out of the inventory
			allow_take = function(inv, listname, index, stack, player) 
				if modMinerTrade.checkValidStack(stack) >= 1 then
					return 0
				else
					return stack:get_count()
				end
			end,
	
			-- on_* - no return value
			-- Called after the actual action has happened, according to what was allowed.
			on_move = function(inv, from_list, from_index, to_list, to_index, count, player) 
				--modMinerTrade.setSafeInventory(playername, inv:get_list("safe"))
				--core.log('action',playername.." colocou "..stack:get_count().." '"..stack:get_name().."' em seu cofre!")
			end,
			on_put = function(inv, listname, index, stack, player) 
				--modMinerTrade.setSafeInventory(playername, inv:get_list("safe"))
				--core.log('action',modMinerTrade.translate("Player '%s' has placed %02d '%s' in his safe!"):format(playername, stack:get_count(), stack:get_name()))
				--local accountname = player:get_player_name()
				if modMinerTrade.checkValidStack(stack) >= 1 then
					local stackValue = modMinerTrade.getValueStack(stack)
					--modMinerTrade.debug("modMinerTrade.convValueToItemList() >>> items = "..dump(items).." | newItem = "..dump(newItem))
					if stackValue >= 1 then
						modMinerTrade.addBalance(accountname, stackValue)
						modMinerTrade.addStatement(
							accountname, stackValue, 
							modMinerTrade.translate("You deposited %02d x '%s'!"):format(stack:get_count(), stack:get_name())
						)
						--stack:take_item(stack:get_count())
						stack:take_item()
						modMinerTrade.doSoundPlayer(playername, "sfx_cash_register", 5)
						modMinerTrade.showAccountBank.frmDeposits(playername)
					end
				else
					modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
				end
				--return stack
			end,
			on_take = function(inv, listname, index, stack, player) 
				--modMinerTrade.setSafeInventory(playername, inv:get_list("safe"))
				--core.log('action',modMinerTrade.translate("Player '%s' has removed %02d '%s' in his safe!"):format(playername, stack:get_count(), stack:get_name()))
			end,
			
		})
		newInv:set_size("deposit", 1)	
		newInv:set_stack("deposit", 1, nil)
		
		local msgBalance = ""
		if modMinerTrade.isExistAcount(accountname) then
			msgBalance = modMinerTrade.translate("You have %02d minercash."):format(modMinerTrade.getBalance(accountname))
			
		else
			msgBalance = modMinerTrade.translate("Player '%s' is not an account holder of this bank."):format(accountname)
		end
		
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		..       "box[6.0,0.25;9.5,9.5;#000000AA]"
		
		..   "label[6.50,0.50;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BANK DEPOSIT") )).."]"
		--..  "textarea[5.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BALANCES")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgBalance)).."]"
		
		..     "box[6.5,1.50;8.5,1.05;#00FF0044]"
		.."textarea[7.25,2.00;9.0,2.0;;"
			..core.formspec_escape(core.colorize("#FFFF00", modMinerTrade.translate("YOUR BALANCE")..":"))..";"
			..core.formspec_escape(core.colorize("#FFFFFF", core.formspec_escape(msgBalance)))
		.."]"
		
		--listcolors[slot_bg_normal;slot_bg_hover;slot_border;tooltip_bgcolor;tooltip_fontcolor]
		.."listcolors[#88888866;#666666;#CCCCCC;#444444;#FFFFFF]"

		.."label[7.00,3.00;"..core.formspec_escape(modMinerTrade.translate("ATM entrance"))..":]"
		.."image[9.00,3.35;2,2;obj_minercoin.png]"
		.."image[10.50,3.75;1,1;gui_arrow.png^[transformR270]"
		.."list[detached:"..core.formspec_escape("deposits_"..playername)..";deposit;11.50,3.75;1,1;]"

		--.."button[3,2.0;2,1;exchange;"..core.formspec_escape(modMinerTrade.translate("DEPOSIT")).."]"

		.."label[7.00,5.00;"..core.formspec_escape(modMinerTrade.translate("Your Inventory"))..":]"
		.."list[current_player;main;7.00,5.50;8,4;]"

		core.show_formspec(playername, "frmAtmDeposits", formspec)
	end,
	frmTransfer = function(playername, txtBeneficiary, txtValue, txtReason, msgDetails) --FORMULÁRIO: TRANSFERÊNCIAS
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		--modMinerTrade.debug("modMinerTrade.showAccountBank.frmTransfer() >>> playername = "..dump(playername).." | accountname = "..dump(accountname).." | txtBeneficiary = "..dump(txtBeneficiary).." | txtValue = "..dump(txtValue).." | txtReason = "..dump(txtReason).." | msgDetails = "..dump(msgDetails))
		
		local msgBalance = ""
		if modMinerTrade.isExistAcount(accountname) then
			msgBalance = modMinerTrade.translate("You have %02d minercash."):format(modMinerTrade.getBalance(accountname))
		else
			msgBalance = modMinerTrade.translate("Player '%s' is not an account holder of this bank."):format(accountname)
		end
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		..       "box[6.0,0.25;9.5,9.5;#000000CC]"
		
		..  "textarea[6.75,1.00;9.0,9.0;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("BALANCES")..":"))..";"..core.formspec_escape(core.colorize("#00FFFF", msgBalance)).."]"
		
		if modMinerTrade.isExistAcount(accountname) then
			if type(txtBeneficiary) ~= "string" then
				txtBeneficiary = ""
			end
			if type(txtValue) == "nil" or txtValue == "" then
				txtValue = "1"
			end
			if type(txtReason) ~= "string" or txtReason:trim() == "" then
				txtReason = modMinerTrade.translate("Transfer for undeclared reason!")
			end
			if type(msgDetails) == "nil" or msgDetails == "" then
				msgDetails = modMinerTrade.translate("Write the 'beneficiary player name' and the 'value in minercash' that want to transfer!")
			end
			formspec = formspec
			--..   "label[5.25,0.50;"..core.formspec_escape(core.colorize("#00FFFF", "WITHDRAWAL IN MINERCASH:")).."]"
			.."field[7.00,3.50;6.00,0.50;txtBeneficiary;"
				..core.formspec_escape(
					core.colorize(
						"#00FFFF", 
						modMinerTrade.translate("BENEFICIARY NAME")..":"
					)
				)..";"
				..core.formspec_escape(txtBeneficiary)
			.."]"
			.."field[7.00,5.00;3.00,0.50;txtValue;"
				..core.formspec_escape(
					core.colorize(
						"#00FFFF", 
						modMinerTrade.translate("VALUE")..":"
					)
				)..";"
				..core.formspec_escape(txtValue)
			.."]"
			.."field[7.00,6.50;9.00,0.50;txtReason;"
				..core.formspec_escape(
					core.colorize(
						"#00FFFF", 
						modMinerTrade.translate("REASON OF TRANSFER")..":"
					)
				)..";"
				..core.formspec_escape(txtReason)
			.."]"
			..  "button[9.85,7.50;4.00,1.00;btnAtmTransfer;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("DO TRANSFER"))).."]"
	
			.."textarea[6.75,8.50;9.0,1.5;;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("DETAILS")..":"))..";"
				..core.formspec_escape(core.colorize("#00FFFF", msgDetails))
			.."]"
		end
		core.show_formspec(playername, "frmAtmTransfer", formspec)
	end,
	frmLoanFunctions = function(playername) --FORMULÁRIO: FUNÇÕES DE EMPRESTIMO
		local accountname = modMinerTrade.bank.player[playername].focused_accountname
		local formspec = "size[16,10]"
		.."bgcolor[#636D7688;false]"
		--.."bgcolor[#636D76FF;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		--..default.gui_slots
		
		..        "box[0.00,0.10;5.50,9.5;#000000]"
		..     "button[0.25,0.50;5.00,0.5;btnAtmMain;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("BACK"))).."]"
		.."button_exit[0.25,6.50;5.00,0.5;;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("EXIT"))).."]"
		
		.."background[6.0,0.25;9.5,9.5;text_atm_front.png]"
		..       "box[6.0,0.25;9.5,9.5;#000000CC]"
		
		..   "label[6.75,0.75;"..core.formspec_escape(core.colorize("#00FFFF", modMinerTrade.translate("LOAN FUNCTIONS")..":")).."]"

		..   "label[9.25,3.25;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("NEW LOANS AVAILABLE"))).."]"
		.."tooltip[btnMinercoin;"..core.formspec_escape(modMinerTrade.translate("List of all loan offers that you can take advantage of at low cost."))..";#CCCC0088;#000000]"
		.."image_button[7.25,2.50;2.00,2.00;obj_moneysuitcase.png;btnLoansAvailable;]"

		..   "label[9.25,5.75;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("LOANS WITH PENDING RETURNS"))).."]"
		.."tooltip[btnMinercoin;"..core.formspec_escape(modMinerTrade.translate("List of all loans you have taken and that are still pending repayment."))..";#CCCC0088;#000000]"
		.."image_button[7.25,5.00;2.00,2.00;obj_credit_card.png;btnLoansPendingReturns;]"

		..   "label[9.25,8.25;"..core.formspec_escape(core.colorize("#FFFFFF", modMinerTrade.translate("RULES FOR LOANS"))).."]"
		.."tooltip[btnMinercoin;"..core.formspec_escape(modMinerTrade.translate("List of all rules for you to have access to a loan."))..";#CCCC0088;#000000]"
		.."image_button[7.25,7.50;2.00,2.00;obj_bank_check.png;btnLoansRules;]"
		
		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
		core.show_formspec(playername, "frmAtmLoanFunctions", formspec)
	end,
}

modMinerTrade.getCashTypes = function()
	return { 
		[1]="minertrade:minercoin",
		[2]="minertrade:minermoney_blue",
		[3]="minertrade:minermoney_green",
		[4]="minertrade:minermoney_yellow",
		[5]="minertrade:minermoney_orange",
		[6]="minertrade:minermoney_red",
		[7]="minertrade:minermoney_black",
	}
end


modMinerTrade.convValueToItemList = function(value)
	if value ~= nil
		and type(value) == "number"
		and value >= 1
	then
		local moneytypes= modMinerTrade.getCashTypes()
		local items = { }
		for i = #moneytypes, 1, -1 do 
			local valMoney = 9 ^ (i - 1)
			local money = math.floor(value / valMoney)
			local decrease = money * valMoney
			value = value - decrease
			if money >= 1 then
				local newItem = {
					name = moneytypes[i],
					amount = money,
					price = decrease
				}
				--modMinerTrade.debug("modMinerTrade.convValueToItemList() >>> items = "..dump(items).." | newItem = "..dump(newItem))
				table.insert(items, newItem)
			end
			if value == 0 then break end
		end
		return items
	end
end

modMinerTrade.delDetachedInventory = function(playername)
   --core.detached_inventories["safe_"..ownername] = nil	
   return core.remove_detached_inventory("deposits_"..playername)
   --return core.remove_detached_inventory_raw("safe_"..ownername)
end


modMinerTrade.onReceiveFields = function(player, formname, fields)
	local playername = player:get_player_name()
	--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> player = "..playername.." | formname = "..formname.." | fields = "..dump(fields))
	if fields.btnAtmMain ~= nil then
		modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
		modMinerTrade.showAccountBank.frmMain(playername)
	elseif fields.quit then
		--são funções importantíssimas para não perder inventário do jogador e nem calça legging no servidor.
		modMinerTrade.doBankSave()
		--local isDeleted = modMinerTrade.delDetachedInventory(playername)
		--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> Database saved and delete detached inventory... Done ["..dump(isDeleted).."]")
	else
		if formname == "frmAtmMain"  then
			if fields.btnBalance ~= nil then
				modMinerTrade.showAccountBank.frmBalance(playername)
			elseif fields.btnStatement ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmStatement(playername)
			elseif fields.btnWithdrawals ~= nil then
				modMinerTrade.showAccountBank.frmWithdrawals(playername)
			elseif fields.btnDeposits ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmDeposits(playername)
			elseif fields.btnTransfers ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmTransfer(playername)
			elseif fields.btnLoans ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmLoanFunctions(playername)
			elseif fields.btnPublicAccess ~= nil then
				modMinerTrade.showAccountBank.inPublicAccess(playername)
			end
		elseif formname == "frmAtmStatement"  then
			modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> player = "..playername.." | formname = "..formname.." | fields = "..dump(fields))
			if fields.fldStatement ~= nil then
				local tblStatement = modMinerTrade.getStatement(playername)
				local fldStatement = core.explode_table_event(fields.fldStatement)
			   modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> fldStatement = "..dump(fldStatement))
				if fldStatement.row ~= nil and type(fldStatement.row) == "number" and fldStatement.row >= 2 and fldStatement.row <= #tblStatement+1 then
					--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>>  fldStatement = "..dump(fldStatement))
					modMinerTrade.showAccountBank.frmStatement(playername, fldStatement.row)
				end
			end
		elseif formname == "frmAtmWithdrawals"  then
			if fields.btnGiveCash ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmGiveCash(playername)
			elseif fields.btnGiveCheck ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
			end
		elseif formname == "frmAtmGiveCash"  then
			--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> player = "..playername.." | formname = "..formname.." | fields = "..dump(fields))
			if fields.btnWithdrawals ~= nil then
				modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
				modMinerTrade.showAccountBank.frmWithdrawals(playername)
			elseif fields.btnAtmGive ~= nil
				and fields.txtValue ~= nil
				and tonumber(fields.txtValue) ~= nil 
				and type(tonumber(fields.txtValue))=="number"
				and tonumber(fields.txtValue) >= 1
			then
				local myValue = fields.txtValue
				local accountname = modMinerTrade.bank.player[playername].focused_accountname
				if modMinerTrade.isExistAcount(accountname) then
					local myBalance = modMinerTrade.getBalance(accountname)
					if tonumber(myValue) <= myBalance then
						local player = core.get_player_by_name(playername)
						if player ~= nil and player:is_player() then
							local delivered = 0
							local items = modMinerTrade.convValueToItemList(tonumber(myValue))
							--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> formname = "..formname.." | items = "..dump(items))
							if items ~= nil 
								and type(items) == "table"
								and #items >= 1 
							then
								local minv = player:get_inventory()
								for _, item in ipairs(items) do
									--if not pinv:contains_item("customer_gives",item) then
									local itemdesc = item.name.." "..item.amount
									if minv:room_for_item("main",itemdesc) then -- verifica se compartimento de Recebimento de pagamento do vendedor tem espaço
										minv:add_item("main",itemdesc)
										delivered = delivered + item.price
									else
										break
									end
								end
							end
							if delivered >= 1 then
								modMinerTrade.addBalance(playername, 0 - delivered)
								modMinerTrade.addStatement(
									playername, 0 - delivered, 
									modMinerTrade.translate("You have withdrawn %02d minercash from your bank account."):format(delivered)
								)
							end
							if delivered == tonumber(myValue) then
								modMinerTrade.doSoundPlayer(playername, "sfx_cash_register", 5)
								modMinerTrade.showAccountBank.frmMain(playername)
							else
								modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
								modMinerTrade.showAccountBank.frmGiveCash(playername,
									tonumber(myValue) - delivered,
									modMinerTrade.translate(
										"You don't have space in your inventory to withdraw so much minercash."
									)
								)
							end
						end
					else
						modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
						modMinerTrade.showAccountBank.frmGiveCash(playername,
							myValue,
							modMinerTrade.translate(
								"The maximum amount you can withdraw is: %02d minercash."
							):format(myBalance)
						)
					end
				else --if modMinerTrade.isExistAcount(playername) then
					modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
				end
			end
		elseif formname == "frmAtmTransfer"  then
			if fields.btnAtmTransfer ~= nil then
				--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> player = "..playername.." | formname = "..formname.." | fields = "..dump(fields))
				local player = core.get_player_by_name(playername)
				if player ~= nil and player:is_player() then
					local accountname = modMinerTrade.bank.player[playername].focused_accountname
					
					local txtBeneficiary = ""
					if fields.txtBeneficiary ~= nil
						and type(fields.txtBeneficiary) == "string"
						and fields.txtBeneficiary:trim() ~= ""
					then
						txtBeneficiary = fields.txtBeneficiary:trim()
					end
						
					local txtValue = 0
					if fields.txtValue ~= nil
						and tonumber(fields.txtValue) ~= nil 
						and type(tonumber(fields.txtValue))=="number"
						and tonumber(fields.txtValue) >= 1
					then
						txtValue = tonumber(fields.txtValue)
					end
					
					local txtReason = modMinerTrade.translate("Transfer for undeclared reason!")
					if fields.txtReason ~= nil
						and type(fields.txtReason)=="string"
						and fields.txtReason:trim() ~= ""
					then
						--txtReason = string.format("%-150s",fields.txtReason:trim()):trim() --max 150 craracters
						txtReason = fields.txtReason:trim():sub(1, 150) --max 150 craracters
					end
					
					modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> playername = "..dump(playername).." | accountname = "..dump(accountname).." | txtBeneficiary = "..dump(txtBeneficiary).." | txtValue = "..dump(txtValue).." | txtReason = "..dump(txtReason))
					--modMinerTrade.debug("modMinerTrade.onReceiveFields() >>> accountname = "..dump(accountname))
					if modMinerTrade.isExistAcount(accountname) then
						if txtBeneficiary ~= "" and  txtValue >= 1 then
							if modMinerTrade.isExistAcount(txtBeneficiary) then
								if accountname ~= txtBeneficiary then
									local thisBalance = modMinerTrade.getBalance(accountname)
									if txtValue <= thisBalance then
										modMinerTrade.addBalance(txtBeneficiary, txtValue)
										modMinerTrade.addStatement(txtBeneficiary, txtValue, 
											modMinerTrade.translate("The '%s' say: '%s'"):format(playername, txtReason)
										)
										modMinerTrade.addBalance(accountname, 0 - txtValue)
										modMinerTrade.addStatement(accountname, 0 - txtValue, 
											modMinerTrade.translate("The '%s' say to '%s': '%s'"):format(playername, txtBeneficiary, txtReason)
										)
										
										--modMinerTrade.addTransferProof_v1(player, accountname, txtBeneficiary, txtValue, txtReason)
										modMinerTrade.addTransferProof_v2(player, accountname, txtBeneficiary, txtValue, txtReason)										
										
										--modMinerTrade.doSoundPlayer(playername, "sfx_atm", 5)
										--modMinerTrade.showAccountBank.frmTransfer(playername, txtBeneficiary, txtValue, txtReason, msgDetails) --FORMULÁRIO: SAQUE
										modMinerTrade.doSoundPlayer(playername, "sfx_cash_register", 5)
										modMinerTrade.showAccountBank.frmMain(playername)
									else
										modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
										modMinerTrade.showAccountBank.frmTransfer(
											playername, txtBeneficiary, txtValue, txtReason, 
											modMinerTrade.translate("The bank account holder '%s' does not have enough balance to make this requested transfer."):format(accountname)
										)
									end
								else
									modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
									modMinerTrade.showAccountBank.frmTransfer(
										playername, txtBeneficiary, txtValue, txtReason, 
										modMinerTrade.translate("Account holder '%s' cannot be a beneficiary of itself."):format(accountname)
									)
								end
							else
								modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
								modMinerTrade.showAccountBank.frmTransfer(
									playername, txtBeneficiary, txtValue, txtReason, 
									modMinerTrade.translate("The beneficiary '%s' does not have a current account with this bank."):format(txtBeneficiary)
								)
							end
						else
							modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
							modMinerTrade.showAccountBank.frmTransfer(playername)
						end
					else
						--modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
						--modMinerTrade.showAccountBank.frmTransfer(playername)
						modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
						modMinerTrade.showAccountBank.frmTransfer(
							playername, nil, nil, nil, 
							modMinerTrade.translate("There is no account holder '%s' in this bank."):format(accountname)
						)
					end
				end --Final of: if player ~= nil and player:is_player() then
			end
		end
	end
end
			

--###############################################################################################################

core.register_node("minertrade:atm", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("PUBLIC ATM")
	).."\n\t* "..modMinerTrade.translate("Deposit and Withdraw your minercash into your bank account."),
	--inventory_image =  core.inventorycube("text_atm_front_1.png"),
	--inventory_image =  "text_atm_front_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX,
	paramtype2 = "facedir",
	
	--legacy_facedir_simple = true, --<=Nao sei para que serve!
	is_ground_content = false,
	groups = {cracky=1},
	--groups = {cracky=3,oddly_breakable_by_hand=3},
	--sounds = default.node_sound_glass_defaults(),
	tiles = {
		--[[
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"text_atm_front_1.png",
		--]]
		
		--[[ 
		"safe_side.png",
		"safe_side.png",
		"safe_side.png",
		"safe_side.png",
		"safe_side.png",
		"safe_side.png^text_atm_front.png",
		--]]
		
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png^text_atm_front.png",
	},

	on_place = function(itemstack, placer, pointed_thing)
		local playername = placer:get_player_name()

		if not pointed_thing.type == "node" then
			return itemstack
		end

		local posAbove = pointed_thing.above --acima
		local posUnder = pointed_thing.under --abaixo
		if not placer or not placer:is_player() or
			not core.registered_nodes[core.get_node(posAbove).name].buildable_to
		then --Verifica se pode construir sobre os objetos construiveis
			return itemstack
		end
		
		local nodeUnder = core.get_node(posUnder)
		if core.registered_nodes[nodeUnder.name].on_rightclick then --Verifica se o itema na mao do jogador tem funcao rightclick
			return core.registered_nodes[nodeUnder.name].on_rightclick(posUnder, nodeUnder, placer, itemstack)
		end
		
		if 
			modMinerTrade.canInteract(playername) 
			or modMinerTrade.getNodesInRange(posAbove, 5, "minertrade:dispensingmachine") >= 1 
		then
			local facedir = core.dir_to_facedir(placer:get_look_dir())
			--core.chat_send_player(playername, "[ATM] aaaaaa")
			core.set_node(posAbove, {
				name = "minertrade:atm",
				param2 = facedir,
			})
			local meta = core.get_meta(posAbove)
			meta:set_string("infotext", 
				--[[
				modMinerTrade.translate(
					"PUBLIC ATM\n* Save your money in the ATM, and withdraw your money in your Personal Safe or other ATM in the shops scattered around the map."
				)
				--]]
				core.colorize("#00FF00", 
					modMinerTrade.translate("PUBLIC ATM")
				).."\n\t* "..modMinerTrade.translate("Deposit and Withdraw your minercash into your bank account.")
			)
			local now = os.time() --Em milisegundos
			if not modMinerTrade.canInteract(playername) then
				meta:set_string("opentime", now + modMinerTrade.getDelayToUse())
			else
				meta:set_string("opentime", now)
			end
			itemstack:take_item() -- itemstack:take_item() = Ok
		else
			core.chat_send_player(playername, 
				core.colorize("#00ff00", "["..modMinerTrade.translate("ATM").."]: ")
				..modMinerTrade.translate("You can not install this 'ATM' too far from a 'Dispensing Machine'!")
			)
			--return itemstack -- = Cancel
		end
		
		return itemstack
	end,
	
	on_rightclick = function(pos, node, clicker)
		local clickername = clicker:get_player_name()
		local meta = core.get_meta(pos)
		--meta:set_string("infotext", modMinerTrade.translate("PUBLIC ATM\n* Save your money in the ATM, and withdraw your money in your Personal Safe or other ATM in the shops scattered around the map."))
		local opentime = tonumber(meta:get_string("opentime")) or 0
		local now = os.time() --Em milisegundos
		if now >= opentime or modMinerTrade.canInteract(clickername) then
			--[[ 
			modMinerTrade.showInventory(
				clicker, 
				clickername, 
				modMinerTrade.translate("PUBLIC ATM - Account of '%s':"):format(clickername)
			)
			--]]
			
			--modMinerTrade.doSoundPlayer(clickername, "sfx_atm", 5)
			--modMinerTrade.showAccountBank.frmMain(clickername)
			modMinerTrade.showAccountBank.inAtm(clickername, clickername)
		else
			--core.sound_play("sfx_failure", {object=clicker, max_hear_distance=5.0,})
			modMinerTrade.doSoundPlayer(clickername, "sfx_failure", 5)
			core.chat_send_player(clickername, 
				core.colorize("#00ff00", "["..modMinerTrade.translate("ATM").."]: ")
				..modMinerTrade.translate(
					"The ATM will only run %02d seconds after it is installed!"
				):format(opentime - now)
			)
		end
		--modMinerTrade.debug("on_rightclick() >>> "..modMinerTrade.getUrlDatabase())
	end,
})

--[[ --]]
core.register_craft({
	output = 'minertrade:atm',
	recipe = {
		{"default:steel_ingot"	,"default:steel_ingot"		,"default:steel_ingot"},
		{"default:steel_ingot"	,"default:obsidian_glass"	,"default:steel_ingot"},
		{"default:steel_ingot"	,"default:mese"				,"default:steel_ingot"},
	}
})
--]]
core.register_alias("atm","minertrade:atm")
core.register_alias(modMinerTrade.translate("atm"),"minertrade:atm")

core.register_on_player_receive_fields(function(sender, formname, fields)
	return modMinerTrade.onReceiveFields(sender, formname, fields)
end)

core.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	if not modMinerTrade.isExistAcount(playername) then
		modMinerTrade.createAcount(playername)
	end
end)

core.register_on_leaveplayer(function(player)
	modMinerTrade.doBankSave()
end)

core.register_on_shutdown(function()
	modMinerTrade.doBankSave()
end)
