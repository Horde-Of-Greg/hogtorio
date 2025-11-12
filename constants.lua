local VOLTAGES = {
    _voltages = {
        "lv",
        "mv",
        "hv",
        "ev",
    },
    iter = function (self)
        return ipairs(self._voltages)
    end,
    getMultiplier = function(self, voltage, perfect)
        local exponent_penalty = 3
        local base = 2
        if perfect then base = 4 end
        return base ^ (self[voltage] - exponent_penalty)
    end,
    getBetterVoltages = function(self, voltage)
        local result = {}
        local level = self[voltage]
        for _, v in ipairs(self._voltages) do
            if self[v] > level then
                table.insert(result, v)
            end
        end
        return result
    end
}

setmetatable(VOLTAGES, {
    __index = function(table, key)
        -- Find the index of the voltage
        if type(key) == "string" then
            for i, v in ipairs(table._voltages) do
                if v == key then
                    return i
                end
            end
        -- Find the voltage by index
        elseif type(key) == "number" then
            for i, v in ipairs(table._voltages) do
                if i == key then
                    return v
                end
            end
        end
        return nil
    end
})

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

local COIL_TIERS = {
    "cupronickel",
    "kanthal",
    "nichrome",
    -- "rtm",
    -- "hss-g",
    -- "naq",
    -- "trinium",
    -- "tritanium"
}

local COMMON_MATERIAL_RELATIONSHIPS = {
    plate = "ingot",
    stick = "ingot",
}

local PROCESSING_MACHINES = {}
local MULTIBLOCKS = {}

return {
    VOLTAGES = VOLTAGES,
    VOLTAGE_TINTS = VOLTAGE_TINTS,
    VOLTAGE_FUEL_VALUES = VOLTAGE_FUEL_VALUES,
    COMMON_MATERIAL_RELATIONSHIPS = COMMON_MATERIAL_RELATIONSHIPS,
    COIL_TIERS = COIL_TIERS,
}