
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