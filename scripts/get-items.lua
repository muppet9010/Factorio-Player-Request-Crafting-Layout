local Utils = require("utility/utils")
local Logging = require("utility/logging")
local GetItems = {}

GetItems.CreateGlobals = function()
    global.getItems = global.getItems or {}
    global.getItems.orderedItemGroups = global.getItems.orderedItemGroups or {}
    global.getItems.orderedItemRows = global.getItems.orderedItemRows or {}
end

GetItems.OnStartup = function()
    GetItems.MakeOrderedItemList()
end

GetItems.MakeOrderedItemList = function()
    global.getItems.orderedItemGroups = {}

    local groups = {}
    for _, item in pairs(game.item_prototypes) do
        if (item.flags == nil or item.flags["hidden"] ~= true) and item.subgroup.name ~= "tool" then
            groups[item.group.name] = groups[item.group.name] or {name = item.group.name, order = item.group.order, subgroups = {}}
            local group = groups[item.group.name]
            group.subgroups[item.subgroup.name] = group.subgroups[item.subgroup.name] or {name = item.subgroup.name, order = item.subgroup.order, items = {}}
            local subgroup = group.subgroups[item.subgroup.name]
            subgroup.items[item.name] = {name = item.name, order = item.order}
        end
    end

    local sortedGroups, rows = {}, 0
    for _, group in pairs(groups) do
        local sortedGroup = {name = group.name, order = group.order, subgroups = {}}
        for _, subgroup in pairs(group.subgroups) do
            local sortedSubgroup = {name = subgroup.name, order = subgroup.order, items = {}}
            for _, item in pairs(subgroup.items) do
                table.insert(sortedSubgroup.items, item)
            end
            table.sort(
                sortedSubgroup.items,
                function(itemA, itemB)
                    if itemA.order < itemB.order then
                        return true
                    else
                        return false
                    end
                end
            )
            rows = rows + math.ceil(#sortedSubgroup.items / 10)
            table.insert(sortedGroup.subgroups, sortedSubgroup)
        end
        table.sort(
            sortedGroup.subgroups,
            function(subgroupA, subgroupB)
                if subgroupA.order < subgroupB.order then
                    return true
                else
                    return false
                end
            end
        )
        table.insert(sortedGroups, sortedGroup)
    end
    table.sort(
        sortedGroups,
        function(groupA, groupB)
            if groupA.order < groupB.order then
                return true
            else
                return false
            end
        end
    )

    global.getItems.orderedItemGroups = sortedGroups
    global.getItems.orderedItemRows = rows
end

return GetItems
