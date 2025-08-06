
local VOLTAGES = {
    "lv",
    "mv",
    "hv",
    "ev",
}

local VOLTAGE_TINTS = {
    low = {},
    medium = {},
    high = {},
    extreme = {},
}

local VOLTAGE_FUEL_VALUES = {
    lv = "32J",
    mv = "128J",
    hv = "512J",
    ev = "2048J",
}

function VOLTAGE_FUEL_VALUES:multiplier(voltage, mult)
    local base = self[voltage]
    local base_num = tonumber(string.match(base, "%d+"))
    local unit = string.match(base, "%a+")
    return tostring(base_num * mult) .. unit
end

function VOLTAGE_FUEL_VALUES:get_consumption(voltage)
    local base = self[voltage]
    return string.gsub(base, "J", "W") -- Convert Joules to Watts
end


return {
    VOLTAGES = VOLTAGES,
    VOLTAGE_TINTS = VOLTAGE_TINTS,
    VOLTAGE_FUEL_VALUES = VOLTAGE_FUEL_VALUES,
}