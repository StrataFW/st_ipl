---@param ipl string
local function activateOne(ipl)
    if not IsIplActive(ipl) then RequestIpl(ipl) end
end

---@param ipl string
local function deactivateOne(ipl)
    if IsIplActive(ipl) then RemoveIpl(ipl) end
end

---@param ipl string|string[]
---@param activate boolean
function EnableIpl(ipl, activate)
    if type(ipl) == 'table' then
        for _, v in pairs(ipl) do EnableIpl(v, activate) end
        return
    end
    if activate then activateOne(ipl) else deactivateOne(ipl) end
end

---@param interiorId integer
---@param name string
local function activateSet(interiorId, name)
    if not IsInteriorEntitySetActive(interiorId, name) then
        ActivateInteriorEntitySet(interiorId, name)
    end
end

---@param interiorId integer
---@param name string
local function deactivateSet(interiorId, name)
    if IsInteriorEntitySetActive(interiorId, name) then
        DeactivateInteriorEntitySet(interiorId, name)
    end
end

---@param interiorId integer|integer[]
---@param props string|string[]
---@param state boolean
---@param refresh boolean?
function SetIplPropState(interiorId, props, state, refresh)
    if type(interiorId) == 'table' then
        for _, id in pairs(interiorId) do SetIplPropState(id, props, state, refresh) end
        return
    end

    if type(props) == 'table' then
        for _, p in pairs(props) do SetIplPropState(interiorId, p, state, false) end
    elseif type(props) == 'string' then
        if state then activateSet(interiorId, props) else deactivateSet(interiorId, props) end
    end

    if refresh then RefreshInterior(interiorId) end
end

exports('EnableIpl', EnableIpl)
exports('SetIplPropState', SetIplPropState)
