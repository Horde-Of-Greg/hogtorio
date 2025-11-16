require('util.array')
local event_handler = require('runtime.event_handler')
local custom_state_trackers = require('runtime.states_tracker').CustomStateTrackers

--- This module managers the registrations of machines that require tool modules. This includes the machines, the modules, and the recipes that need them

local TOOL_MODULE_STATE_SOURCE = "tool_modules"
local TOOL_MODULE_PRIORITY = 10

local function init_storage()
    if not storage.tool_system then
    storage.tool_system = {
        registered_entities = {},
        registered_prototypes = {},
        module_categories = {},
        recipe_requirements = {}
    }
    end
end

local function register_prototype(prototype_name)
    if is_not_key(storage.tool_system.registered_prototypes, prototype_name) then
        storage.tool_system.registered_prototypes[prototype_name] = true
    end
end

local function register_entity(entity)
    storage.tool_system.registered_entities[entity.unit_number] = entity
    custom_state_trackers:add_tracker_source(entity, TOOL_MODULE_STATE_SOURCE, TOOL_MODULE_PRIORITY)
end

local deregister_entity = function(entity)
    storage.tool_system.registered_entities[entity.unit_number] = nil
    custom_state_trackers:remove_tracker(entity)
end

local function register_module(module_name)
    if is_not_key(storage.tool_system.module_categories, module_name) then
        storage.tool_system.module_categories[module_name] = true
    end
end

local function register_recipe(recipe_name, required_modules)
    storage.tool_system.recipe_requirements[recipe_name] = required_modules
end

local function get_registered_entities()
    return get_keys(storage.tool_system.registered_entities)
end
local function get_registered_prototypes()
    return get_keys(storage.tool_system.registered_prototypes)
end
local function is_registered_prototype(prototype_name)
    return is_key(storage.tool_system.registered_prototypes, prototype_name)
end
local function get_tool_modules()
    return get_keys(storage.tool_system.module_categories)
end
local function get_recipe_requirements(recipe_name)
    return storage.tool_system.recipe_requirements[recipe_name]
end

local function has_required_modules(entity, required_modules)
    if not required_modules then return {"NOMODULES"} end

    local module_inventory = entity.get_module_inventory()
    if not module_inventory then
        game.print("Entity " .. entity.name .. " has no module inventory.")
        return {"UNREACHABLE_MODULE_INVENTORY"}
    end

    local missing_modules = {}
    for required_module_id, required_module_name in pairs(required_modules) do
        local found = false
        for i = 1, #module_inventory do
            local module_stack = module_inventory[i]
            if module_stack.valid_for_read and module_stack.prototype.name == required_module_name then
                found = true
                break
            end
        end
        if not found then
            table.insert(missing_modules, required_module_name)
        end
    end
    return missing_modules
end


local pending_status_updates = {}
local current_crafting_state_tick = 0
local prev_missing_modules = {}

local function update_entity_crafting_state(entity_unit_number)
    if not storage.tool_system.registered_entities[entity_unit_number] then return end

    local entity = storage.tool_system.registered_entities[entity_unit_number]
    if not is_registered_prototype(entity.name) then return end

    local current_recipe = entity.get_recipe()
    local recipe_name = current_recipe and current_recipe.name or nil

    local requirements_met
    local missing_modules = {}
    if recipe_name then
        local required_modules = get_recipe_requirements(recipe_name)
        missing_modules = has_required_modules(entity, required_modules)
        if missing_modules[1] == "NOMODULES" then
            requirements_met = true
        elseif missing_modules[1] == "UNREACHABLE_MODULE_INVENTORY" then
            requirements_met = false
        else
            requirements_met = #missing_modules == 0
        end
    else
        requirements_met = true
    end

    local missing_modules_changed = #missing_modules ~= #(prev_missing_modules[entity_unit_number] or {})
    prev_missing_modules[entity_unit_number] = missing_modules

    local tracker = custom_state_trackers:get_tracker(entity)

    if requirements_met then
        tracker:remove_state(TOOL_MODULE_STATE_SOURCE)
    else
        local localizedModuleNames = {}
        for _, module_name in ipairs(missing_modules) do
            table.insert(localizedModuleNames, prototypes.item[module_name].localised_name or module_name)
        end
        
        if current_recipe then
            local localized_req_recipe_name = prototypes.recipe[recipe_name].localised_name or recipe_name
            local state = {
                custom_status = {
                    diode = defines.entity_status_diode.red,
                    label = "Can't craft: missing required tool modules for " ..
                        localized_req_recipe_name .. ": " .. table.concat(localizedModuleNames, ", ")
                },
                disabled_by_script = true
            }
            tracker:add_state(TOOL_MODULE_STATE_SOURCE, state)

            -- Handle player GUI refresh
            if missing_modules_changed then
                for _, player in pairs(game.connected_players) do
                    if player.opened and player.opened == entity then
                        if not pending_status_updates[player.index] then
                            pending_status_updates[player.index] = {}
                        end
                        player.opened = nil
                        pending_status_updates[player.index][entity_unit_number] = true
                        current_crafting_state_tick = game.tick
                    end
                end
            end
        end
    end
end

event_handler:on("update", function (event)
    if current_crafting_state_tick < game.tick then
        for player_index, entities in pairs(pending_status_updates) do
            local player = game.get_player(player_index)
            if player and player.valid then
                for entity_unit_number, _ in pairs(entities) do
                    local entity = storage.tool_system.registered_entities[entity_unit_number]
                    if entity and entity.valid and not player.opened then
                        player.opened = entity
                    end
                end
            end
        end
        pending_status_updates = {}
        current_crafting_state_tick = math.huge
    end
end)

return {
    init_storage = init_storage,
    register_prototype = register_prototype,
    register_entity = register_entity,
    deregister_entity = deregister_entity,
    register_module = register_module,
    register_recipe = register_recipe,
    get_registered_entities = get_registered_entities,
    get_registered_prototypes = get_registered_prototypes,
    is_registered_prototype = is_registered_prototype,
    get_tool_modules = get_tool_modules,
    get_recipe_requirements = get_recipe_requirements,
    has_required_modules = has_required_modules,
    update_entity_crafting_state = update_entity_crafting_state,
    
}