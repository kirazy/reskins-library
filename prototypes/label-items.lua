local function create_label_item(label)
    data:extend({
        {
            type = "item",
            name = "reskins-lib-"..label.."-tier-label",
            icon = reskins.lib.directory.."/graphics/icons/icon-"..label..".png",
            icon_size = 40, icon_mipmaps = 2,
            flags = { "hidden" },
            order = "zzz-reskins-tier-icons",
            stack_size = 10
        }
    })
end

local icons = {
    "dots",
    "half-circle",
    "rectangle",
    "rounded-half-circle",
    "rounded-rectangle",
    "teardrop",
}

for _, v in pairs(icons) do
    create_label_item(v)
end