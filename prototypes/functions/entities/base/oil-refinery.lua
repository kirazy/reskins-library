-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---Provides vanilla-style sprite definition for oil refinery corpse `animation` field. See [Prototype/Corpse](https://wiki.factorio.com/Prototype/Corpse).
---@param tint data.Color
---@return data.RotatedAnimationVariations
local function corpse_animation(tint)
	---@type data.RotatedAnimation
	local animation = {
		layers = {
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/remnants/oil-refinery-remnants-base.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25),
				scale = 0.5,
			},
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/remnants/oil-refinery-remnants-mask.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25),
				tint = tint,
				scale = 0.5,
			},
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/remnants/oil-refinery-remnants-highlights.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25),
				blend_mode = reskins.lib.settings.blend_mode,
				scale = 0.5,
			},
		},
	}

	return make_rotated_animation_variations_from_sheet(1, animation)
end

---Reskins the named assembling machine with vanilla-style oil refinery sprites and color masking, and sets up appropriate corpse, explosion, and particle prototypes
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? data.Color
---@param make_tier_labels? boolean
function reskins.lib.apply_skin.oil_refinery(name, tier, tint, make_tier_labels)
	---@type SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "oil-refinery",
		base_entity_name = "oil-refinery",
		mod = "lib",
		group = "base",
		particles = { ["big-tint"] = 5, ["medium"] = 2 },
		tier_labels = make_tier_labels,
		tint = tint and tint or reskins.lib.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	inputs.defer_to_data_updates = true -- angelspetrochem > 0.9.19 modifies icon in data-updates

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][name .. "-remnants"]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint)

	-- Reskin entity
	entity.graphics_set = {
		animation = reskins.lib.sprites.make_4way_animation_from_spritesheet({
			layers = {
				{
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-base.png",
					width = 386,
					height = 430,
					shift = util.by_pixel(0, -7.5),
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-mask.png",
					width = 386,
					height = 430,
					shift = util.by_pixel(0, -7.5),
					tint = inputs.tint,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-highlights.png",
					width = 386,
					height = 430,
					shift = util.by_pixel(0, -7.5),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-shadow.png",
					width = 674,
					height = 426,
					shift = util.by_pixel(82.5, 26.5),
					draw_as_shadow = true,
					scale = 0.5,
				},
			},
		}),
		working_visualisations = {
			{
				fadeout = true,
				constant_speed = true,
				north_position = util.by_pixel(34, -65),
				east_position = util.by_pixel(-52, -61),
				south_position = util.by_pixel(-59, -82),
				west_position = util.by_pixel(57, -58),
				animation = {
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-fire.png",
					line_length = 10,
					width = 40,
					height = 81,
					frame_count = 60,
					animation_speed = 0.75,
					scale = 0.5,
					draw_as_glow = true,
					shift = util.by_pixel(0, -14.25),
				},
			},
			{
				fadeout = true,
				north_animation = {
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-light.png",
					width = 321,
					height = 205,
					blend_mode = "additive",
					draw_as_glow = true,
					shift = util.by_pixel(-1, -50),
					scale = 0.5,
				},
				east_animation = {
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-light.png",
					width = 321,
					x = 321,
					height = 205,
					blend_mode = "additive",
					draw_as_glow = true,
					shift = util.by_pixel(-1, -50),
					scale = 0.5,
				},
				south_animation = {
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-light.png",
					width = 321,
					x = 321 * 2,
					height = 205,
					blend_mode = "additive",
					draw_as_glow = true,
					shift = util.by_pixel(-1, -50),
					scale = 0.5,
				},
				west_animation = {
					filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-light.png",
					width = 321,
					x = 321 * 3,
					height = 205,
					blend_mode = "additive",
					draw_as_glow = true,
					shift = util.by_pixel(-1, -50),
					scale = 0.5,
				},
			},
		},
		water_reflection = {
			pictures = {
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-reflection.png",
				priority = "extra-high",
				width = 40,
				height = 48,
				shift = util.by_pixel(5, 95),
				variation_count = 4,
				scale = 5,
			},
			rotate = false,
			orientation_to_variation = true,
		},
	}
end
