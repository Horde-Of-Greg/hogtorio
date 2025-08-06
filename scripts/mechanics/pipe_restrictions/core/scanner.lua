
if not storage.register_entities then
    storage.registered_entities = {}
end

function register_entity(entity)
    storage.registered_entities[entity.unit_number] = entity
end

function deregister_entity(entity)
    storage.registered_entities[entity.unit_number] = nil
end

function check_prototype_restriction(prototype_name, fluid_name)
    if is_not_key(storage.pipe_restrictions, prototype_name) then
        return false
    end

    local categories = storage.pipe_restrictions[prototype_name]
    for _, category in ipairs(categories) do
        if is_key(storage.fluid_restrictions, category) and contains(storage.fluid_restrictions[category], fluid_name) then
            return true
        end
    end

    return false
end

function check_entity_restriction(entity, fluid_name)
    if is_not_key(storage.registered_entities, entity.unit_number) then
        return false
    end

    local prototype_name = entity.name
    return check_prototype_restriction(prototype_name, fluid_name)
end

-- Handle incompatibility by queuing the entity for damage, and then going through them in a stochastic manner
if not storage.pipe_destruction_queue then
    storage.pipe_destruction_queue = {}
end

-- function queue_entity_for_destruction(entity)
--     if is_not_key(storage.registered_entities, entity.unit_number) then
--         return
--     end

--     if not contains(storage.pipe_destruction_queue, entity.unit_number) then
--         table.insert(storage.pipe_destruction_queue, entity.unit_number)
--     end
-- end

function process_entity_for_destruction(entity_id, entity)
    -- if #storage.pipe_destruction_queue == 0 then
    --     return
    -- end

    if entity and entity.valid then
        storage.registered_entities[entity_id] = nil
        local vol = entity.prototype.fluidbox_prototypes[1].volume
        local fluid_name = get_keys(entity.fluidbox.get_fluid_segment_contents(1))[1]
        entity.remove_fluid{name=fluid_name, amount=math.floor(vol * 2)}
        for _, player in pairs(game.connected_players) do
            player.disable_alert(defines.alert_type.entity_destroyed)
            -- (entity, icon, messsage, show_on_map)
            player.add_custom_alert(
                entity,
                { type = "item", name = entity.prototype.name },    
                storage.fluid_destruction_messages[entity.name],
                true
            )
        end
        entity.die()
        for _, player in pairs(game.connected_players) do
            player.enable_alert(defines.alert_type.entity_destroyed)
        end
  
    end
end

function scan_entity(entity_id, entity)
    if not entity or not entity.valid then
        storage.registered_entities[entity_id] = nil
        return
    end
    -- Check if entity has any restriction rules
    if is_not_key(storage.pipe_restrictions, entity.name) then
        storage.registered_entities[entity_id] = nil
        return
    end
    -- Check if entity has fluid inside
    if not entity.fluidbox[1] then return end
    
    -- Check compatibility with current fluid
    if not check_entity_restriction(entity, entity.fluidbox[1].name) then
        process_entity_for_destruction(entity_id, entity)
    end
end

function scan()
    if not storage.registered_entities then
        return
    end

    local current_queued_entity = storage.current_queued_entity
    if current_queued_entity and not storage.registered_entities[current_queued_entity] then
        storage.current_queued_entity = nil
    end

    local next_entity, entity = next(storage.registered_entities, current_queued_entity)
    if not next_entity then
        current_queued_entity = next_entity
        next_entity, entity = next(storage.registered_entities, current_queued_entity)
        if not next_entity then
            storage.current_queued_entity = nil
            return
        end
    end

    storage.current_queued_entity = next_entity
    scan_entity(next_entity, entity)
end

