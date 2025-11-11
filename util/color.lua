
function hex_to_rgba(hex)
    -- Remove # or 0x prefix if present
    if hex:sub(1, 1) == '#' then
        hex = hex:sub(2)
    elseif hex:sub(1, 2) == '0x' then
        hex = hex:sub(3)
    end

    -- Remove the '#' and convert to RGBA
    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    local a = 1  -- Default alpha value
    return {r, g, b, a}
end