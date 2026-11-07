minetest.register_privilege("salary",  {
   description=modMinerTrade.translate("Only players with this privilege will receive a daily payment."), 
   --give_to_singleplayer=false,
})

modMinerTrade.salary = {
	isEnabled = function()
		if modMinerTrade.salary.enabled == nil then
			modMinerTrade.salary.enabled = (minetest.settings:get_bool("minertrade.salary.enabled") ~= false)
			minetest.settings:set_bool("minertrade.salary.enabled", modMinerTrade.salary.enabled)
		end
		return modMinerTrade.salary.enabled
	end,
	--value = tonumber(minetest.settings:get("minertrade.salary.value") or 1),
	getValue = function()
		if modMinerTrade.salary.value == nil then
			modMinerTrade.salary.value = minetest.settings:get("minertrade.salary.value")
			if type(modMinerTrade.salary.value) ~= "number" 
				or tonumber(modMinerTrade.salary.value) < 1
			then
				modMinerTrade.salary.value = 1
				minetest.settings:set("minertrade.salary.value", modMinerTrade.salary.value)
			end
		end
		return tonumber(modMinerTrade.salary.value)
	end,
	--intervalcheck = tonumber(minetest.settings:get("minertrade.salary.intervalcheck") or 60),
	getIntervalCheck = function()
		if modMinerTrade.salary.intervalcheck == nil then
			modMinerTrade.salary.intervalcheck = minetest.settings:get("minertrade.salary.intervalcheck")
			if modMinerTrade.salary.intervalcheck == nil 
				or type(tonumber(modMinerTrade.salary.intervalcheck)) ~= "number" 
				or tonumber(modMinerTrade.salary.intervalcheck) < 1
				or tonumber(modMinerTrade.salary.intervalcheck) > (60*60*24)
			then
				modMinerTrade.salary.intervalcheck = 60
				minetest.settings:set("minertrade.salary.intervalcheck", modMinerTrade.salary.intervalcheck)
			end
		end
		return tonumber(modMinerTrade.salary.intervalcheck)
	end,
	doPay = function()
	   local players = minetest.get_connected_players()
      if #players >= 1 then
         if modMinerTrade.bank.last_pay ~= minetest.get_day_count() then
            modMinerTrade.bank.last_pay = minetest.get_day_count()
            local valueSalary = modMinerTrade.salary.getValue()
            local description = modMinerTrade.translate("The Government deposited the %2d° salary in your bank account!"):format(minetest.get_day_count())
            local payedPeoples = 0
         	for _, player in ipairs(players) do
               local playername = player:get_player_name()
               if minetest.get_player_privs(playername).salary then
               	if modMinerTrade.isExistAcount(playername) then
                  	local publicBalance = modMinerTrade.getBalance("THE GOVERNMENT")
                  	local colorTitle = ""
                  	if publicBalance >= valueSalary then
                  	   payedPeoples = payedPeoples + 1
                  	   modMinerTrade.addBalance("THE GOVERNMENT", 0 - valueSalary)
	                  	modMinerTrade.addBalance(playername, valueSalary)
	                  	modMinerTrade.addStatement(playername, valueSalary, description)
	                  	colorTitle = "#00FF00"
	                     modMinerTrade.doSoundPlayer(playername, "sfx_cash_register", 5)
                     else
                        colorTitle = "#FF0000"
                        modMinerTrade.doSoundPlayer(playername, "sfx_failure", 5)
                        description = modMinerTrade.translate("The Government did not have enough balance to deposit the %2dth salary in its bank account!"):format(minetest.get_day_count())
                  	end
                     minetest.chat_send_player(
                        playername,
                        core.colorize(colorTitle, 
                        	"["..modMinerTrade.translate("THE GOVERNMENT").."]: "
                        )..description
                     )
               	--else
               		--modMinerTrade.debug("api_payday.lua >>> "..playername.." sem conta!")
               	end
               end
         	end  -- Final off for _, player in ipairs(players) do
         	if payedPeoples >= 1 then
            	modMinerTrade.addStatement("THE GOVERNMENT", 0 - (payedPeoples * valueSalary), 
            	   modMinerTrade.translate("Daily Bonus Payment for %02d players online!"):format(payedPeoples)
            	)
         	end
		   	minetest.log('action',"[MINERTRADE] "..description)
         	modMinerTrade.doBankSave()
         end
      end
	end,
}

minetest.after(3.5, function()
	if modMinerTrade.salary.isEnabled() then
	   modMinerTrade.salary.timer = 0
	   minetest.register_globalstep(function(dtime)
	      modMinerTrade.salary.timer = modMinerTrade.salary.timer + dtime
	      if modMinerTrade.salary.timer >= modMinerTrade.salary.getIntervalCheck() then
	         modMinerTrade.salary.timer = 0
	         modMinerTrade.salary.doPay()
	      end
	   end)
   end
end)
