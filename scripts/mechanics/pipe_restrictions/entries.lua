
require('core.loader')

-- Register fluid categories
register_fluid_category("lv-power")
register_fluid_category("mv-power")
register_fluid_category("hv-power")
register_fluid_category("ev-power")

-- Assign fluids to each category
register_fluid("voltage-lv", "lv-power")
register_fluid("voltage-mv", "mv-power")
register_fluid("voltage-hv", "hv-power")
register_fluid("voltage-ev", "ev-power")

-- Register pipe restrictions for each prototype
register_prototype("lv-wire", {"lv-power"}, "Voltage Overload!")
register_prototype("mv-wire", {"lv-power", "mv-power"}, "Voltage Overload!")
register_prototype("hv-wire", {"lv-power", "mv-power", "hv-power"}, "Voltage Overload!")
register_prototype("ev-wire", {"lv-power", "mv-power", "hv-power", "ev-power"}, "Voltage Overload!")