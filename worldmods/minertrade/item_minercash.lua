

--#########################################################################################

minetest.register_craftitem("minertrade:minercoin", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("MINERCOIN")
	).."\n* "..modMinerTrade.translate("Basic craftable minercash with gold and steel."),
	inventory_image = "obj_minercoin.png",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=1, trade=1, coin=1},
})

minetest.register_craft({
	output = "minertrade:minercoin",
	recipe = {
		{"default:gold_ingot","default:steel_ingot","default:gold_ingot"},
	},
	--https://github.com/minetest/minetest_game/blob/master/mods/default/craftitems.lua
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "minertrade:minercoin",
	cooktime = 5,
})

minetest.register_alias(
	modMinerTrade.translate("minercoin"), 
	"minertrade:minercoin"
)

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_blue", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("BLUE MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^1),
	inventory_image = "obj_minermoney_satured.png^[multiply:#0088FF",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=9, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_blue",
	recipe = {
		{"minertrade:minercoin", "minertrade:minercoin", "minertrade:minercoin"},
		{"minertrade:minercoin", "minertrade:minercoin", "minertrade:minercoin"},
		{"minertrade:minercoin", "minertrade:minercoin", "minertrade:minercoin"}
	},
})

minetest.register_craft({
	output = "minertrade:minercoin 9",
	recipe = {
		{"minertrade:minermoney_blue"},
	},
})


minetest.register_alias("minermoney_blue", "minertrade:minermoney_blue")
minetest.register_alias("minermoneyblue", "minertrade:minermoney_blue")
minetest.register_alias("minermoney1", "minertrade:minermoney_blue")
minetest.register_alias("minercash9", "minertrade:minermoney_blue")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_green", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("GREEN MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^2),
	inventory_image = "obj_minermoney_satured.png^[multiply:#00FF00",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=81, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_green",
	recipe = {
		{"minertrade:minermoney_blue", "minertrade:minermoney_blue", "minertrade:minermoney_blue"},
		{"minertrade:minermoney_blue", "minertrade:minermoney_blue", "minertrade:minermoney_blue"},
		{"minertrade:minermoney_blue", "minertrade:minermoney_blue", "minertrade:minermoney_blue"}
	},
})

minetest.register_craft({
	output = "minertrade:minermoney_blue 9",
	recipe = {
		{"minertrade:minermoney_green"},
	},
})


minetest.register_alias("minermoney_green", "minertrade:minermoney_green")
minetest.register_alias("minermoneygreen", "minertrade:minermoney_green")
minetest.register_alias("minermoney2", "minertrade:minermoney_green")
minetest.register_alias("minercash81", "minertrade:minermoney_green")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_yellow", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("YELLOW MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^3),
	inventory_image = "obj_minermoney_satured.png^[multiply:#FFFF00",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=729, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_yellow",
	recipe = {
		{"minertrade:minermoney_green", "minertrade:minermoney_green", "minertrade:minermoney_green"},
		{"minertrade:minermoney_green", "minertrade:minermoney_green", "minertrade:minermoney_green"},
		{"minertrade:minermoney_green", "minertrade:minermoney_green", "minertrade:minermoney_green"}
	},
})

minetest.register_craft({
	output = "minertrade:minermoney_green 9",
	recipe = {
		{"minertrade:minermoney_yellow"},
	},
})


minetest.register_alias("minermoney_yellow", "minertrade:minermoney_yellow")
minetest.register_alias("minermoneyyellow", "minertrade:minermoney_yellow")
minetest.register_alias("minermoney3", "minertrade:minermoney_yellow")
minetest.register_alias("minercash729", "minertrade:minermoney_yellow")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_orange", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("ORANGE MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^4),
	inventory_image = "obj_minermoney_satured.png^[multiply:#FF8800",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=6561, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_orange",
	recipe = {
		{"minertrade:minermoney_yellow", "minertrade:minermoney_yellow", "minertrade:minermoney_yellow"},
		{"minertrade:minermoney_yellow", "minertrade:minermoney_yellow", "minertrade:minermoney_yellow"},
		{"minertrade:minermoney_yellow", "minertrade:minermoney_yellow", "minertrade:minermoney_yellow"}
	},
})

minetest.register_craft({
	output = "minertrade:minermoney_yellow 9",
	recipe = {
		{"minertrade:minermoney_orange"},
	},
})


minetest.register_alias("minermoney_orange", "minertrade:minermoney_orange")
minetest.register_alias("minermoneyorange", "minertrade:minermoney_orange")
minetest.register_alias("minermoney4", "minertrade:minermoney_orange")
minetest.register_alias("minercash6561", "minertrade:minermoney_orange")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_red", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("RED MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^5),
	inventory_image = "obj_minermoney_satured.png^[multiply:#FF0000",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=59049, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_red",
	recipe = {
		{"minertrade:minermoney_orange", "minertrade:minermoney_orange", "minertrade:minermoney_orange"},
		{"minertrade:minermoney_orange", "minertrade:minermoney_orange", "minertrade:minermoney_orange"},
		{"minertrade:minermoney_orange", "minertrade:minermoney_orange", "minertrade:minermoney_orange"}
	},
})

minetest.register_craft({
	output = "minertrade:minermoney_orange 9",
	recipe = {
		{"minertrade:minermoney_red"},
	},
})


minetest.register_alias("minermoney_red", "minertrade:minermoney_red")
minetest.register_alias("minermoneyred", "minertrade:minermoney_red")
minetest.register_alias("minermoney5", "minertrade:minermoney_red")
minetest.register_alias("minercash59049", "minertrade:minermoney_red")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney_black", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("BLACK MINERMONEY")
	).."\n* "..modMinerTrade.translate("Equals %02d minercash."):format(9^6),
	inventory_image = "obj_minermoney_satured.png^[multiply:#666666",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=531441, trade=1, money=1},
})

minetest.register_craft({
	output = "minertrade:minermoney_black",
	recipe = {
		{"minertrade:minermoney_red", "minertrade:minermoney_red", "minertrade:minermoney_red"},
		{"minertrade:minermoney_red", "minertrade:minermoney_red", "minertrade:minermoney_red"},
		{"minertrade:minermoney_red", "minertrade:minermoney_red", "minertrade:minermoney_red"}
	},
})

minetest.register_craft({
	output = "minertrade:minermoney_red 9",
	recipe = {
		{"minertrade:minermoney_black"},
	},
})


minetest.register_alias("minermoney_black", "minertrade:minermoney_black")
minetest.register_alias("minermoneyblack", "minertrade:minermoney_black")
minetest.register_alias("minermoney6", "minertrade:minermoney_black")
minetest.register_alias("minercash531441", "minertrade:minermoney_black")

--##########################################################################################################


minetest.register_craftitem("minertrade:checkbank", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("BANK CHECK")
	).."\n* "..modMinerTrade.translate("Equivalent to as much minercash as your creator wants.."),
	inventory_image = "obj_bank_check.png",
	stack_max=9, --Acumula 9 por slot
	groups = {cash=0, trade=1},
})

--[[
minetest.register_craft({
	output = "minertrade:checkbank",
	recipe = {
		{"minertrade:minermoney", "minertrade:minermoney", "minertrade:minermoney"},
		{"minertrade:minermoney", "minertrade:minermoney", "minertrade:minermoney"},
		{"minertrade:minermoney", "minertrade:minermoney", "minertrade:minermoney"}
	},
})
--]]

--[[  
minetest.register_craft({
	output = "minertrade:minermoney_green 1",
	recipe = {
		{"minertrade:checkbank"},
	},
})
--]]

--[[
minetest.register_alias(
	modMinerTrade.translate("checkbank"), 
	"minertrade:checkbank"
)
--]]

--##########################################################################################################

minetest.register_craftitem("minertrade:creditcard", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("CREDIT CARD")
	).."\n\t* "..modMinerTrade.translate("Allows you to access the bank account anywhere in the world."),
	inventory_image = "obj_credit_card.png",
	--stack_max=9, --Acumula 9 por slot
	groups = {cash=0, trade=1},
	on_use = function(itemstack, player)
		local playername = player:get_player_name()
		modMinerTrade.showAccountBank.inCreditCard(playername, playername)
	end,
})

--[[
minetest.register_craft({
	output = "minertrade:creditcard",
	recipe = {
		{"minertrade:minermoney_green"},
	},
})
--]]

--[[
minetest.register_craft({
	output = "minertrade:creditcard",
	recipe = {
		{"minertrade:checkbank", "minertrade:checkbank", "minertrade:checkbank"},
		{"minertrade:checkbank", "minertrade:checkbank", "minertrade:checkbank"},
		{"minertrade:checkbank", "minertrade:checkbank", "minertrade:checkbank"}
	},
})

minetest.register_craft({
	output = "minertrade:checkbank 9",
	recipe = {
		{"minertrade:creditcard"},
	},
})
--]]

minetest.register_alias("creditcard", "minertrade:creditcard")
minetest.register_alias(modMinerTrade.translate("creditcard"), "minertrade:creditcard")

--##########################################################################################################

minetest.register_craftitem("minertrade:minermoney", {
	description = core.colorize("#00FF00", 
		modMinerTrade.translate("OBSOLETE MONEY")
	).."\n* "..modMinerTrade.translate("You can make money from it."),
	inventory_image = "obj_moneybag.png",
	stack_max=99, --Acumula 9 por slot
	groups = {cash=0, trade=0, money=0},
})

minetest.register_craft({
	output = "minertrade:minercoin 9",
	recipe = {
		{"minertrade:minermoney"},
	},
})
