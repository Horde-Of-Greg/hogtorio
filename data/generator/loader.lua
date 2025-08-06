local generate_material = require("material.material")
local generate_processing_machine = require("building.processing_machine")
local generate_item_group = require("group.item_group")
local generate_recipe_group = require("group.recipe_group")

return {
    material = generate_material,
    processing_machine = generate_processing_machine,
    item_group = generate_item_group,
    recipe_group = generate_recipe_group,
}