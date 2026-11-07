-- riderkoo_skin: nastaví hráči skin "riderkoo" z Minecraftu
local TEXTURE = "riderkoo_skin.png"
local only_player = core.settings:get("riderkoo_skin_player") or ""

local function apply_skin(player)
    local name = player:get_player_name()
    if only_player ~= "" and name ~= only_player then
        return
    end
    if core.global_exists("player_api") then
        player_api.set_texture(player, 1, TEXTURE)
    else
        player:set_properties({textures = {TEXTURE}})
    end
end

core.register_on_joinplayer(function(player)
    -- malé zpoždění, aby game (player_api) stihla nastavit model
    core.after(0.5, function()
        if player:is_valid() then
            apply_skin(player)
        end
    end)
end)
