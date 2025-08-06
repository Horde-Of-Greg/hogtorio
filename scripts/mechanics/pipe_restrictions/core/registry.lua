
require('util.array_manipulation')

-- Register storage if it doesn't exist
if not storage.fluid_categories then
    storage.fluid_categories = {}
end

if not storage.fluid_restrictions then
    storage.fluid_restrictions = {}
end

if not storage.pipe_restrictions then
    storage.pipe_restrictions = {}
end

-- Destruction message for each pipe
if not storage.fluid_destruction_messages then
    storage.fluid_destruction_messages = {}
end


function register_fluid_category(category_name)
    storage.fluid_categories[category_name] = true
end

function register_fluid(fluid_name, category_name)
    if is_not_key(storage.fluid_categories, category_name) then
        error("Fluid category '" .. category_name .. "' does not exist.")
    end

    if is_not_key(storage.fluid_restrictions, category_name) then
        storage.fluid_restrictions[category_name] = {}
    end

    if not contains(storage.fluid_restrictions[category_name], fluid_name) then
        table.insert(storage.fluid_restrictions[category_name], fluid_name)
    end
end

-- Registers pipe entity and restrict it to the fluid category
function register_prototype(prototype_name, fluid_categories, destruction_message)
    if is_not_key(storage.pipe_restrictions, prototype_name) then
        storage.pipe_restrictions[prototype_name] = {}
    end
    for _, fluid_category in ipairs(fluid_categories) do
        if not contains(storage.pipe_restrictions[prototype_name], fluid_category) then
            table.insert(storage.pipe_restrictions[prototype_name], fluid_category)
        end
    end
    if not destruction_message then
        storage.fluid_destruction_messages[prototype_name] = "Alert: Fluid category '" .. prototype_name .. "' is incompatible with the pipe."
    else
        storage.fluid_destruction_messages[prototype_name] = destruction_message
    end
end





function get_fluid_categories()
    return get_keys(storage.fluid_categories)
end

function get_registered_entities()
    return get_keys(storage.registered_entities)
end

function get_registered_prototypes()
    return get_keys(storage.pipe_restrictions)
end

function is_registered_prototype(prototype_name)
    return is_key(storage.pipe_restrictions, prototype_name)
end

function get_fluid_restrictions()
    return storage.fluid_restrictions
end

