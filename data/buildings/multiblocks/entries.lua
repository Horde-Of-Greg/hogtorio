
return {
    {
        name = "ebf",
        locale_name = "Electric Blast Furnace",
        width = 5,
        height = 5,
        horizontal_energy_hatch = true,
        recipe = {
            ingredients = {
                {"iron-plate", 5},
                {"steel-plate", 2},
                {"copper-plate", 3}
            }
        },
        states = {
            {
                name = "idle",
                next_active = "idle",
                next_inactive = "idle",
                layers = {{
                    filename = "__hogtorio__/graphics/buildings/multiblocks/ebf/ebf.png",
                    width = 160,
                    height = 160
                }}
            }
        }
    }
}