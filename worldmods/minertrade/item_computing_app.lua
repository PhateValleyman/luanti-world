

if core.global_exists("modComputing") then
   modComputing.add_app("minertrade:btnWebBank", {
   	icon_name = "btnWebBank",
   	icon_title = modMinerTrade.translate("WEB BANK"),
   	icon_descryption = modMinerTrade.translate("Allows you to access the bank account anywhere in the world."),
   	icon_type = "button", --types: button/button_exit
   	icon_image = "obj_credit_card.png",
   	on_iconclick = function(player)
   	   local playername = player:get_player_name()
   	   core.log(
			   "action","["..modMinerTrade.modName:upper().."] "
			   ..modMinerTrade.translate(
               "Player '@1' is trying to access the '@2' via the '@3'!"
               , playername
               , "bank account"
               , "computing app"
            )
         )
			modMinerTrade.showAccountBank.inCreditCard(playername, playername)
   	end,
   })
end