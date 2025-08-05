require("util.array_manipulation")

local overlay_set = {"bright", "magnetic"}

metallic_set = {"bolt", "dust_small", "dust_tiny", "ingot_double", 'ingot', 'nugget', 'plate_dense', 'plate_double', 'plate', 'round', 'screw', 'stick_long', 'stick'}
bright_set = {}
shiny_set = {
    "bolt", "dust", "dust_small", "dust_tiny", "gear", "gear_small", "ingot_double", "ingot", "nugget", "plate_dense", "plate_double", "plate", "ring", "round", "screw", "stick_long", "stick"
}

-- Checking if material is in the set, otherwise fallback to dull
-- {material_set, is_overlay}
function material_check(material, icon_set)
    if icon_set == 'metallic' and contains(metallic_set, material) then
        return {'metallic', false}
    elseif icon_set == 'bright' and contains(bright_set, material) then
        return {'bright', true}
    elseif icon_set == 'shiny' and contains(shiny_set, material) then
        return {'shiny', true}
    else return {'dull', false}
    end
end
