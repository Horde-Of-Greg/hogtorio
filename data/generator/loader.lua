local generate_material = require("material.material")
local generate_processing_machine = require("building.processing_machine")
local generate_item_group = require("group.item_group")
local generate_recipe_group = require("group.recipe_group")
local generate_item = require("item")
local generate_module_group = require("module.module_group")
local generate_multiblock_ebf = require("building.ebf")

return {
    material = generate_material,
    processing_machine = generate_processing_machine,
    multiblocks = {
        ebf = generate_multiblock_ebf,
    },
    item_group = generate_item_group,
    recipe_group = generate_recipe_group,
    module_group = generate_module_group,
    item = generate_item,
}