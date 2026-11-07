modComponents.addDrops = function(drop_id, drop_rarity, to_node)
	--FONTE: https://dev.minetest.net/minetest.register_node#More_on_drop
	local newDropList = {}
	local props = minetest.registered_items[to_node]
	if props.drop then 
		newDropList=props.drop.items 
		table.insert(newDropList, {items = {drop_id},rarity = drop_rarity})
		minetest.override_item(
			to_node, {
				drop = {
					max_items=#newDropList,
					items=newDropList
				}
			}
		)
	else
		--[[ --]]
		newDropList={
			max_items=2, 
			items={
				{items = {drop_id},rarity = drop_rarity}
			}
		}
		minetest.override_item(
			to_node, {
				drop = newDropList
			}
		)
		--[[ --]]
	end
end

-- Dig 'components:bioresin' in 'default:jungletree'
modComponents.addDrops("default:jungletree", 1, 'default:jungletree') -- rarity:1 = 1/1 = 100%
modComponents.addDrops("components:bioresin", 5, 'default:jungletree') -- rarity:5 = 1/5 = 20%
-- Dig 'components:quartzo_crystal_pink' in 'default:gravel'
modComponents.addDrops("components:quartzo_crystal_pink", 20, 'default:gravel') -- rarity:20 = 1/20 = 05%

if minetest.global_exists("unified_inventory") then
	unified_inventory.add_category_items('plants', {"components:bioresin"})
	unified_inventory.add_category_items('minerals', {"components:quartzo_crystal_pink"})
end
--########################################################################################################################
