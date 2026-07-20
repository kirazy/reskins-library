-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Library
--
-- See LICENSE.md in the project directory for license information.

---@namespace Reskins.Api

---Provides version comparison tools.
---
---This module is deprecated. Use `helpers.compare_versions` directly.
---
---### Examples
---```lua
---local _version = require("__reskins-library__.api.version")
---```
---@class Version
local _version = {}

-- Setup additional version comparison functions

---Check if `version` is newer than `version_to_compare_with`.
---
---### Examples
---```lua
---if _version.is_newer(mods["reskins-library"], "2.1.8") then
---    -- Do something for versions more recent than 2.1.8.
---end
---```
---
---### Returns
---@return boolean|nil # `true` if `version` is newer than `version_to_compare_with`, `false` if `version` is older than `version_to_compare_with`, `nil` if the version strings are invalid.
---
---### Parameters
---@param version string # The version of interest; a semantic version string.
---@param version_to_compare_with string # The version to compare with; a semantic version string.
---@deprecated helpers.compare_versions(version, version_to_compare_with) > 0
function _version.is_newer(version, version_to_compare_with)
	return helpers.compare_versions(version, version_to_compare_with) > 0
end

--- Check if `version` is the same as or is newer than `version_to_compare_with`.
---
---### Examples
---```lua
---if _version.is_same_or_newer(mods["reskins-library"], "2.1.8") then
---    -- Do something for versions from 2.1.8 or newer.
---end
---```
---
---### Returns
---@return boolean|nil # `true` if `version` is the same as or newer than `version_to_compare_with`, `false` if `version` is older than `version_to_compare_with`, `nil` if the version strings are invalid.
---
---### Parameters
---@param version string # The version of interest; a semantic version string.
---@param version_to_compare_with string # The version to compare with; a semantic version string.
---@deprecated helpers.compare_versions(version, version_to_compare_with) >= 0
function _version.is_same_or_newer(version, version_to_compare_with)
	return helpers.compare_versions(version, version_to_compare_with) >= 0
end

--- Check if `version` is the same as `version_to_compare_with`.
---
---### Returns
---@return boolean|nil # `true` if `version` is the same as `version_to_compare_with`, `false` if `version` is different from `version_to_compare_with`, `nil` if the version strings are invalid.
---
---### Examples
---```lua
---if _version.is_same(mods["reskins-library"], "2.1.8") then
---    -- Do something for version 2.1.8.
---end
---```
---
---### Parameters
---@param version string # The version of interest; a semantic version string.
---@param version_to_compare_with string # The version to compare with; a semantic version string.
---@deprecated Use helpers.compare_versions(version, version_to_compare_with) == 0
function _version.is_same(version, version_to_compare_with)
	return helpers.compare_versions(version, version_to_compare_with) == 0
end

---Check if `version` is the same as or is older than `version_to_compare_with`.
---
---### Returns
---@return boolean|nil # `true` if `version` is the same as or older than `version_to_compare_with`, `false` if `version` is newer than `version_to_compare_with`, `nil` if the version strings are invalid.
---
---### Examples
---```lua
---if _version.is_same_or_older(mods["reskins-library"], "2.1.8") then
---    -- Do something for versions from 2.1.8 or older.
---end
---```
---
---### Parameters
---@param version string # The version of interest; a semantic version string.
---@param version_to_compare_with string # The version to compare with; a semantic version string.
---@deprecated Use helpers.compare_versions(version, version_to_compare_with) <= 0
function _version.is_same_or_older(version, version_to_compare_with)
	return helpers.compare_versions(version, version_to_compare_with) <= 0
end

---
---Checks if `version` is older than `version_to_compare_with`.
---
---### Returns
---@return boolean|nil # `true` if `version` is older than `version_to_compare_with`, `false` if `version` is newer than `version_to_compare_with`, `nil` if the version strings are invalid.
---
---### Examples
---```lua
---if _version.is_older(mods["reskins-library"], "2.1.8") then
---    -- Do something for versions older than 2.1.8.
---end
---```
---
---### Parameters
---@param version string # The version of interest; a semantic version string.
---@param version_to_compare_with string # The version to compare with; a semantic version string.
---@deprecated Use helpers.compare_versions(version, version_to_compare_with) < 0
function _version.is_older(version, version_to_compare_with)
	return helpers.compare_versions(version, version_to_compare_with) < 0
end

return _version
