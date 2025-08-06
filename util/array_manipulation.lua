
function contains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function extend_array(source, destination)
    for _, value in ipairs(source) do
        if not contains(destination, value) then
            table.insert(destination, value)
        end
    end
end

function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function get_keys(tbl)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

function is_key(tbl, key)
    return tbl[key] ~= nil
end

function is_not_key(tbl, key)
    return tbl[key] == nil
end