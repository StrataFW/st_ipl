---@meta

---@class st_ipl.DLCFlag
---@field enabled boolean
---@field build   integer

---@class st_ipl.IplModule
---@field LoadDefault?       fun()
---@field Enable?            fun(state: boolean)
---@field interiorId?        integer
---@field currentInteriorId? integer
---@field InteriorId?        integer

---@class st_ipl.ScaleformParam
---@field type 'bool'|'int'|'float'|'string'|'buttonName'
---@field value any
