local Constants = require("constants")

data:extend(
    {
        {
            type = "shortcut",
            name = "player_request_crafting_layout-apply_logistic_layout_button",
            action = "lua",
            toggleable = false,
            icon = {
                filename = Constants.AssetModName .. "/graphics/shortcuts/apply_logistic_layout_button_24.png",
                width = 24,
                height = 24
            }
        }
    }
)
