-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---Provides vanilla-style sprite definition for splitter corpse `animation` field. See [Prototype/Corpse](https://wiki.factorio.com/Prototype/Corpse).
---@param tint table # [Types/Color](https://wiki.factorio.com/Types/Color)
---@return table animation # [Types/RotatedAnimation](https://wiki.factorio.com/Types/RotatedAnimation)
local function corpse_animation(tint)
	return {
		layers = {
			-- Base
			{
				filename = "__reskins-library__/graphics/entity/base/splitter/remnants/splitter-remnants-base.png",
				width = 190,
				height = 190,
				direction_count = 4,
				shift = util.by_pixel(3.5, 1.5),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-library__/graphics/entity/base/splitter/remnants/splitter-remnants-mask.png",
				width = 190,
				height = 190,
				direction_count = 4,
				tint = tint,
				shift = util.by_pixel(3.5, 1.5),
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-library__/graphics/entity/base/splitter/remnants/splitter-remnants-highlights.png",
				width = 190,
				height = 190,
				direction_count = 4,
				blend_mode = reskins.lib.settings.blend_mode,
				shift = util.by_pixel(3.5, 1.5),
				scale = 0.5,
			},
		},
	}
end

---Provides vanilla-style sprite definition for splitter `structure` field. See [Prototype/Splitter](https://wiki.factorio.com/Prototype/Splitter).
---@param tint table # [Types/Color](https://wiki.factorio.com/Types/Color)
---@return table structure # [Types/Animation4Way](https://wiki.factorio.com/Types/Animation4Way)
local function entity_structure(tint)
	return {
		north = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/north/splitter-north-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 160,
					height = 70,
					shift = util.by_pixel(7, 0),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/north/splitter-north-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 160,
					height = 70,
					shift = util.by_pixel(7, 0),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/north/splitter-north-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 160,
					height = 70,
					shift = util.by_pixel(7, 0),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
		east = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 84,
					shift = util.by_pixel(4, 13),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 84,
					shift = util.by_pixel(4, 13),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 84,
					shift = util.by_pixel(4, 13),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
		south = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/south/splitter-south-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 164,
					height = 64,
					shift = util.by_pixel(4, 0),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/south/splitter-south-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 164,
					height = 64,
					shift = util.by_pixel(4, 0),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/south/splitter-south-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 164,
					height = 64,
					shift = util.by_pixel(4, 0),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
		west = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 86,
					shift = util.by_pixel(5, 12),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 86,
					shift = util.by_pixel(5, 12),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 86,
					shift = util.by_pixel(5, 12),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
	}
end

---Provides vanilla-style sprite definition for splitter `structure_patch` field. See [Prototype/Splitter](https://wiki.factorio.com/Prototype/Splitter).
---@param tint table # [Types/Color](https://wiki.factorio.com/Types/Color)
---@return table structure_patch # [Types/Animation4Way](https://wiki.factorio.com/Types/Animation4Way)
local function entity_structure_patch(tint)
	return {
		north = util.empty_sprite(),
		east = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-top_patch-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 104,
					shift = util.by_pixel(4, -20),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-top_patch-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 104,
					shift = util.by_pixel(4, -20),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/east/splitter-east-top_patch-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 90,
					height = 104,
					shift = util.by_pixel(4, -20),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
		south = util.empty_sprite(),
		west = {
			layers = {
				-- Base
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-top_patch-base.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 96,
					shift = util.by_pixel(5, -18),
					scale = 0.5,
				},
				-- Mask
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-top_patch-mask.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 96,
					shift = util.by_pixel(5, -18),
					tint = tint,
					scale = 0.5,
				},
				-- Highlights
				{
					filename = "__reskins-library__/graphics/entity/base/splitter/west/splitter-west-top_patch-highlights.png",
					frame_count = 32,
					line_length = 8,
					priority = "extra-high",
					width = 94,
					height = 96,
					shift = util.by_pixel(5, -18),
					blend_mode = reskins.lib.settings.blend_mode,
					scale = 0.5,
				},
			},
		},
	}
end

---Reskins the named splitter with vanilla-style splitter sprites and color masking, and sets up appropriate corpse, explosion, and particle prototypes
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? table # [Types/Color](https://wiki.factorio.com/Types/Color)
---@param make_tier_labels? boolean
---@param reskin_vanilla_entity? boolean
function reskins.lib.apply_skin.splitter(name, tier, tint, make_tier_labels, reskin_vanilla_entity)
	---@type SetupStandardEntityInputs
	local inputs = {
		type = "splitter",
		icon_name = "splitter",
		base_entity_name = "splitter",
		mod = "lib",
		group = "base",
		particles = { ["medium"] = 1, ["big"] = 4 },
		tier_labels = make_tier_labels or false,
		tint = tint and tint or reskins.lib.tiers.get_belt_tint(tier),
	}

	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	if reskin_vanilla_entity == false then
		reskins.lib.tiers.add_tier_labels_to_prototype_by_reference(tier, entity)
		return
	end

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][name .. "-remnants"]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint)

	-- Reskin entity
	entity.structure = entity_structure(inputs.tint)
	entity.structure_patch = entity_structure_patch(inputs.tint)
end
