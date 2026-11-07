--FONTE: https://forum.core.net/viewtopic.php?pid=48124

modMinerTrade.debug = function(text, playername)
	if text ~= nil
		and type(text) == "string"
		and text ~= ""
	then
		if core.settings:get_bool("minertrade.debug") then
			if playername ~= nil
				and type(playername) == "string"
				and playername ~= ""
			then
				local player = core.get_player_by_name(playername)
				if player ~=nil and player:is_player() then
					core.chat_send_player(
						playername, text
					)
					core.log('warning',"["..modMinerTrade.modName:upper()..":DEBUG:"..playername.."] "..text)
				else
					core.log('error',
						"["..modMinerTrade.modName:upper()..":DEBUG] "
						..modSoundChat.translate(
							"Unable to address debug for player '%s'."
						):format(dump(playername))
					)
					core.log('warning',"["..modMinerTrade.modName:upper()..":DEBUG] "..text)
				end
			else
				core.chat_send_all(text)
				core.log('warning',"["..modMinerTrade.modName:upper()..":DEBUG] "..text)
			end
		end
	end
end

modMinerTrade.doBankSave_v1 = function()
	--modMinerTrade.debug("modMinerTrade.doBankSave() >>> "..modMinerTrade.getUrlDatabase())
	local file = io.open(modMinerTrade.getUrlDatabase(), "w")
	if file then
		local content = core.serialize(modMinerTrade.bank)
		--modMinerTrade.debug("modMinerTrade.doBankSave() >>> content = "..dump(content))
		if modMinerTrade.save_compressed then
			content = core.encode_base64(content)
		end
		file:write(content)
		file:close()
		
		core.log('action',"[MINERTRADE] "..modMinerTrade.translate("Saving data bank in the file '%s'!"):format(modMinerTrade.getUrlDatabase()))
	else
		core.log('error',"[MINERTRADE:ERRO] "..modMinerTrade.translate("The file '%s' is not in table format!"):format(modMinerTrade.getUrlDatabase()))
	end
end

modMinerTrade.doBankSave_v2 = function()
	--[[
		Source: https://gemini.google.com/app/ebf8179946b48a71
	--]]
	if type(modMinerTrade.isSaveProcess)~="boolean" or modMinerTrade.isSaveProcess ~= true then -- To prevent the save process from being overwritten by another.
		modMinerTrade.isSaveProcess = true -- Records that the saving process has started.
		local mainPath = modMinerTrade.getUrlDatabase()
		local tempPath = mainPath .. ".tmp"
		local bakPath  = mainPath .. ".bak"

		-- 1. Serializa os dados antes de abrir qualquer arquivo
		local content = core.serialize(modMinerTrade.bank)
		if modMinerTrade.save_compressed then
			content = core.encode_base64(content)
		end

		-- 2. Escreve no arquivo temporário (.tmp)
		local file = io.open(tempPath, "w")
		if not file then
			core.log('error', "[MINERTRADE:ERRO] " .. modMinerTrade.translate("Could not create temp file '%s'!"):format(tempPath))
			modMinerTrade.isSaveProcess = false -- Records that the saving process has been completed.
			return
		end

		file:write(content)
		file:flush() -- Força a gravação física no disco
		file:close()

		-- 3. Faz o backup do arquivo antigo (se existir) e renomeia o temporário para o principal
		os.remove(bakPath)
		os.rename(mainPath, bakPath)
		local success, err = os.rename(tempPath, mainPath)

		if success then
			core.log('action', "[MINERTRADE] " .. modMinerTrade.translate("Saving data bank in the file '%s'!"):format(mainPath))
		else
			core.log('error', "[MINERTRADE:ERRO] " .. modMinerTrade.translate("Failed to rename temp file: %s"):format(tostring(err)))
		end
		modMinerTrade.isSaveProcess = false -- Records that the saving process has been completed.
	end
end

modMinerTrade.doBankLoad_v1 = function()
	--modMinerTrade.debug("modMinerTrade.doBankSave() >>> "..modMinerTrade.getUrlDatabase())
	local file = io.open(modMinerTrade.getUrlDatabase(), "r")
	if file then
		if modMinerTrade.save_compressed then
			modMinerTrade.bank = core.deserialize(core.decode_base64(file:read("*all")))
		else
			modMinerTrade.bank = core.deserialize(file:read("*all"))
		end
		--modMinerTrade.debug("modMinerTrade.doBankLoad() >>> modMinerTrade.bank = "..dump(modMinerTrade.bank))
		file:close()
		if not modMinerTrade.bank or type(modMinerTrade.bank) ~= "table" then
			core.log('error',"[MINERTRADE:ERRO] "..modMinerTrade.translate("The file '%s' is not in table format!"):format(modMinerTrade.getUrlDatabase()))
			return { }
		else
			core.log('action',"[MINERTRADE] "..modMinerTrade.translate("Opening '%s' with data bank!"):format(modMinerTrade.getUrlDatabase()))
		end
	end
end

modMinerTrade.doBankLoad_v2 = function()
	--[[
		Source: https://gemini.google.com/app/ebf8179946b48a71
	--]]
	local mainPath = modMinerTrade.getUrlDatabase()
	local bakPath  = mainPath .. ".bak"
	
	 -- Função auxiliar interna para tentar ler e desserializar um arquivo
	local function tryLoadFile(filepath)
		local file = io.open(filepath, "r")
		if not file then return nil end

		local raw_content = file:read("*all")
		file:close()

		if not raw_content or raw_content == "" then
			return nil
		end

		local success, result = pcall(function()
			if modMinerTrade.save_compressed then
				local decoded = core.decode_base64(raw_content)
				return decoded and core.deserialize(decoded) or nil
			else
				return core.deserialize(raw_content)
			end
		end)

		if success and type(result) == "table" then
			return result
		end

		return nil
	end

	-- 1. Tenta carregar o arquivo principal
	local data = tryLoadFile(mainPath)

	-- 2. Se o principal falhar, tenta recuperar do backup (.bak)
	if not data then
		core.log('warning', "[MINERTRADE:AVISO] " .. modMinerTrade.translate("Main database '%s' is corrupted or missing. Trying backup..."):format(mainPath))
		data = tryLoadFile(bakPath)

		if data then
			core.log('action', "[MINERTRADE] " .. modMinerTrade.translate("Restored database from backup '%s'!"):format(bakPath))
			-- Sobrescreve o principal corrompido com os dados restaurados
			modMinerTrade.bank = data
			modMinerTrade.doBankSave()
			return
		end
	end

	-- 3. Atribui os dados carregados ou inicia uma tabela vazia em caso de falha total
	if data then
		modMinerTrade.bank = data
		core.log('action', "[MINERTRADE] " .. modMinerTrade.translate("Opening '%s' with data bank!"):format(mainPath))
	else
		core.log('error', "[MINERTRADE:ERRO] " .. modMinerTrade.translate("The file '%s' is corrupted and no valid backup was found!"):format(mainPath))
		modMinerTrade.bank = {}
	end
end

modMinerTrade.doBankSave = function()
	modMinerTrade.doBankSave_v2()
end

modMinerTrade.doBankLoad = function()
	modMinerTrade.doBankLoad_v2()
end

modMinerTrade.getNodesInRange = function(pos, search_distance, nodenames)
	if pos==nil then return 0 end
	if pos.x==nil or type(pos.x)~="number" then return 0 end
	if pos.y==nil or type(pos.y)~="number" then return 0 end
	if pos.z==nil or type(pos.z)~="number" then return 0 end
	if search_distance==nil or type(search_distance)~="number" and search_distance<=0 then return 0 end
	if nodenames==nil or type(nodenames)~="string" and nodenames=="" then return 0 end

	local minp = {x=pos.x-search_distance,y=pos.y-search_distance, z=pos.z-search_distance}
	local maxp = {x=pos.x+search_distance,y=pos.y+search_distance, z=pos.z+search_distance}
	local nodes = core.find_nodes_in_area(minp, maxp, nodenames)
	--local nodes = core.env:find_nodes_in_area(minp, maxp, nodenames) --deprecado
	return #nodes
end

modMinerTrade.doSoundPlayer = function(playername, sfxFile, intDistace)
	if intDistace == nil or (type(intDistace) == "number" and intDistace>= 0) then
		if type(playername) == "string" and type(sfxFile) == "string" and playername ~= "" and sfxFile ~= "" then
			local player = core.get_player_by_name(playername)
			if player ~=nil and player:is_player() then
				return core.sound_play(sfxFile, {
					object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
					gain = 1.0, -- 1.0 = Volume total
					max_hear_distance = intDistace,
					loop = false,
				})
			end
		end
	end
end

modMinerTrade.canInteract = function(meta, player)
	if player:get_player_name() == meta:get_string("owner") 
		or core.get_player_privs(player:get_player_name()).server
		or core.get_player_privs(player:get_player_name()).checkchest
		or (core.get_modpath("tradelands") and modTradeLands.canInteract(player:getpos(), player:get_player_name()))
	then
		return true
	end
	return false
end

modMinerTrade.floor_pos = function(pos)
	return {
		x=math.floor(pos.x),
		y=math.floor(pos.y),
		z=math.floor(pos.z)
	}
end

modMinerTrade.getPosMachineName = function(posMachine)
	if type(posMachine)=="table" and type(posMachine.x)=="number" and type(posMachine.y)=="number" and type(posMachine.z)=="number" then
		return core.pos_to_string(modMinerTrade.floor_pos(posMachine))
	else
		core.log(
			"error",("[modMinerTrade.getPosMachineName(posMachine='%s')] "):format(dump(posMachine))
			..modMinerTrade.translate("The '%s' parameter must be of the position type (x,y,z)!"):format("posMachine")
		)
	end
end

modMinerTrade.setMachineFlagsAlert = function (posMachine, value)
	if type(posMachine)=="table" and type(posMachine.x)=="number" and type(posMachine.y)=="number" and type(posMachine.z)=="number" then
		local posMachineName = modMinerTrade.getPosMachineName(posMachine)
		
		if type(modMinerTrade.machine_flags)~="table" then modMinerTrade.machine_flags={}	end
		if type(modMinerTrade.machine_flags[posMachineName])~="table" then modMinerTrade.machine_flags[posMachineName]={}	end
		if type(value)=="number" and value>=0  then
			modMinerTrade.machine_flags[posMachineName].lastalert = value
		else
			core.log(
				"error",("[modMinerTrade.setMachineFlagsAlert(posMachine='%s', value='%d')] "):format(dump(posMachine), dump(value))
				..modMinerTrade.translate("The '%s' parameter must be of the non-empty string type!"):format("message")
			)
		end
	else
		core.log(
			"error",("[modMinerTrade.setMachineFlagsAlert(posMachine='%s', value='%s')] "):format(dump(posMachine), dump(dump))
			..modMinerTrade.translate("The '%s' parameter must be of the position type (x,y,z)!"):format("posMachine")
		)
	end
end

modMinerTrade.getMachineFlagsAlert = function (posMachine)
	if type(posMachine)=="table" and type(posMachine.x)=="number" and type(posMachine.y)=="number" and type(posMachine.z)=="number" then
		local posMachineName = modMinerTrade.getPosMachineName(posMachine)
		if type(modMinerTrade.machine_flags)~="table" then modMinerTrade.machine_flags={}	end
		if type(modMinerTrade.machine_flags[posMachineName])~="table" then modMinerTrade.machine_flags[posMachineName]={}	end
		if type(modMinerTrade.machine_flags[posMachineName].lastalert)~="number" or modMinerTrade.machine_flags[posMachineName].lastalert < 0 then modMinerTrade.machine_flags[posMachineName].lastalert = 0 end
		return modMinerTrade.machine_flags[posMachineName].lastalert
	else
		core.log(
			"error",("[modMinerTrade.getMachineFlagsAlert(posMachine='%s', value='%s')] "):format(dump(posMachine), dump(dump))
			..modMinerTrade.translate("The '%s' parameter must be of the position type (x,y,z)!"):format("posMachine")
		)
	end
end

modMinerTrade.sendMailMachine = function(posMachine, ownername, message)
	if core.get_modpath("correio") then
		local mailMachineInterval = (60*60)
		if type(posMachine)=="table" and type(posMachine.x)=="number" and type(posMachine.y)=="number" and type(posMachine.z)=="number" then
			if type(ownername)=="string" and ownername:trim()~="" and core.player_exists(ownername) then --Checks whether the owner really exists.
				if type(message)=="string" and message:trim()~="" then
					local agora = os.time()
					local macFlag = modMinerTrade.getMachineFlagsAlert(posMachine)
					if macFlag + mailMachineInterval < agora then
						local carta = modCorreio.set_mail(
							modMinerTrade.translate("DISPENSING MACHINE").." "..modMinerTrade.getPosMachineName(posMachine), 
							ownername, 
							message:trim()
						)
						if carta~=nil then
							core.log('action',
								modMinerTrade.translate("A letter was sent by the dispensing machine '%s' to '%s' advising about '%s'!"):
								format(modMinerTrade.getPosMachineName(posMachine), ownername , message)
							)
						else
							core.log(
								"error",("[modMinerTrade.sendMailMachine(posMachine='%s', ownername='%s', message='%s')] "):format(dump(posMachine), dump(ownername), dump(message))
								..modMinerTrade.translate("Due to an unknown error, it was not possible to send an email through the dispensing machine!")
							)
						end
						modMinerTrade.setMachineFlagsAlert(posMachine, agora)
					end --if macFlag + mailMachineInterval < agora then
				else
					core.log(
						"error",("[modMinerTrade.sendMailMachine(posMachine='%s', ownername='%s', message='%s')] "):format(dump(posMachine), dump(ownername), dump(message))
						..modMinerTrade.translate("The '%s' parameter must be of the non-empty string type!"):format("message")
					)
				end
			else
				core.log(
					"error",("[modMinerTrade.sendMailMachine(posMachine='%s', ownername='%s', message='%s')] "):format(dump(posMachine), dump(ownername), dump(message))
					..modMinerTrade.translate("The '%s' parameter must be of the non-empty string type!"):format("ownername")
				)
			end
		else
			core.log(
				"error",("[modMinerTrade.sendMailMachine(posMachine='%s', ownername='%s', message='%s')] "):format(dump(posMachine), dump(ownername), dump(message))
				..modMinerTrade.translate("The '%s' parameter must be of the position type (x,y,z)!"):format("posMachine")
			)
		end
	end --if core.get_modpath("correio") then
end

modMinerTrade.errorDispensing = function(erroMessage, player, pos, ownername)
	if type(erroMessage)=="string" and erroMessage:trim()~="" then
		if player:is_player() then
			local playername = player:get_player_name()
			core.chat_send_player(playername, core.colorize("#00ff00", "["..modMinerTrade.translate("DISPENSING MACHINE").."]: ")..erroMessage)
			core.sound_play("sfx_failure", {object=player, max_hear_distance=5.0,})
		end
		if type(pos)~="nil" and type(ownername)=="string" and ownername:trim()~="" then
			modMinerTrade.sendMailMachine(pos, ownername, erroMessage)
		end
	else
		core.log(
			"error",("[modMinerTrade.errorDispensing(erroMessage='%s', player, pos, ownername)] "):format(dump(erroMessage))
			..modMinerTrade.translate("The '%s' parameter must be of the non-empty string type!"):format("erroMessage")
		)
	end
end



