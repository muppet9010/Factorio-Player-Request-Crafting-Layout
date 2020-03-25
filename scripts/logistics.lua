local Logistics = {}
local Events = require("utility/events")

Logistics.OnLoad = function()
    Events.RegisterHandler(defines.events.on_lua_shortcut, "Logistics.OnLuaShortcut", Logistics.OnLuaShortcut)
end

Logistics.OnLuaShortcut = function(event)
    local shortcutName = event.prototype_name
    if shortcutName == "player_request_crafting_layout-apply_logistic_layout_button" then
        local player = game.get_player(event.player_index)
        Logistics.ApplyCraftingLayoutToPlayer(player)
    end
end

Logistics.ApplyCraftingLayoutToPlayer = function(player)
    if player.character == nil then
        return
    end

    --record and remove all old requests
    local oldValues = {}
    for i = 1, player.character_logistic_slot_count do
        local oldValue = player.get_personal_logistic_slot(i)
        if oldValue.name ~= nil then
            oldValues[oldValue.name] = oldValue
        end
        player.clear_personal_logistic_slot(i)
    end

    --add our new requests
    player.character_logistic_slot_count = (global.getItems.orderedItemRows + #global.getItems.orderedItemGroups - 1) * 10
    local slotIndex = 0
    for _, group in pairs(global.getItems.orderedItemGroups) do
        for _, subgroup in pairs(group.subgroups) do
            for _, item in pairs(subgroup.items) do
                slotIndex = slotIndex + 1
                local oldValue = oldValues[item.name] or {}
                player.set_personal_logistic_slot(slotIndex, {name = item.name, min = oldValue.min, max = oldValue.max})
            end
            slotIndex = math.ceil(slotIndex / 10) * 10
        end
        slotIndex = slotIndex + 10
    end
end

return Logistics
