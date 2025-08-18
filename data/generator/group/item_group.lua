
local function generate(item_group)
    local default_localised_name = "Hogtorio Item Group: " .. item_group.name
    local default_localized_description = "Hogtorio Item Group: " .. item_group.name .. " Description"
    local group = {
        type = "item-group",
        name = item_group.name,
        localised_name = item_group.localised_name or default_localised_name,
        localised_description = item_group.localised_description or default_localized_description,
        order = item_group.order or "a",
        icons = item_group.icons,
        icon_size = item_group.icon_size or 128,
    }
    if item_group.localised_name then
        item_group.localised_name = item_group.localised_name
    end
    data:extend({ group })

    if item_group.subgroups then
        for _, subgroup in pairs(item_group.subgroups) do
            local subgroup_entity = {
                type = "item-subgroup",
                name = subgroup.name,
                group = item_group.name,
                order = subgroup.order or "a",
            }
            if subgroup.localised_name then
                subgroup_entity.localised_name = subgroup.localised_name
            end
            data:extend({subgroup_entity})
        end
    end
end

return generate