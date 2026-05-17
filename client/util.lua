local LOAD_TIMEOUT_MS <const> = 5000

---@param name string
---@param model string
---@return integer renderId
function CreateNamedRenderTargetForModel(name, model)
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, false)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        return GetNamedRendertargetRenderId(name)
    end
    return 0
end

---@param name string
---@param model string
---@return boolean
function DrawEmptyRect(name, model)
    local renderId = CreateNamedRenderTargetForModel(name, model)
    local ok = lib.waitFor(function()
        return IsNamedRendertargetRegistered(name) or nil
    end, nil, LOAD_TIMEOUT_MS)
    if not ok then return false end

    SetTextRenderId(renderId)
    SetScriptGfxDrawOrder(4)
    DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 0)
    SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    ReleaseNamedRendertarget(0, name)
    return true
end

---@param t table
---@return integer
function Tablelength(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

---@param movieId integer
---@param scaleformFunction string
---@param parameters table<string, st_ipl.ScaleformParam>?
function SetupScaleform(movieId, scaleformFunction, parameters)
    BeginScaleformMovieMethod(movieId, scaleformFunction)
    ScaleformMovieMethodAddParamTextureNameString_2(scaleformFunction)

    if type(parameters) == 'table' then
        for i = 0, Tablelength(parameters) - 1 do
            local p = parameters['p' .. tostring(i)]
            if     p.type == 'bool'       then ScaleformMovieMethodAddParamBool(p.value)
            elseif p.type == 'int'        then ScaleformMovieMethodAddParamInt(p.value)
            elseif p.type == 'float'      then ScaleformMovieMethodAddParamFloat(p.value)
            elseif p.type == 'string'     then ScaleformMovieMethodAddParamTextureNameString(p.value)
            elseif p.type == 'buttonName' then ScaleformMovieMethodAddParamPlayerNameString(p.value)
            end
        end
    end

    EndScaleformMovieMethod()
    SetScaleformMovieToUseLargeRt(movieId, true)
end

---@param scaleform string
---@return integer handle  -1 on timeout
function LoadScaleform(scaleform)
    return lib.requestScaleformMovie(scaleform, LOAD_TIMEOUT_MS) or -1
end

---@param dict string
---@return boolean
function LoadStreamedTextureDict(dict)
    return lib.requestStreamedTextureDict(dict, LOAD_TIMEOUT_MS) ~= nil
end

---@param ped integer
---@return integer handle  -1 on timeout
function GetPedheadshot(ped)
    local handle = RegisterPedheadshot(ped)
    local ok = lib.waitFor(function() return IsPedheadshotReady(handle) or nil end, nil, LOAD_TIMEOUT_MS)
    return ok and handle or -1
end

---@param ped integer
---@return string|nil
function GetPedheadshotTexture(ped)
    local handle = GetPedheadshot(ped)
    if handle == -1 then
        print('[st_ipl] ped headshot not ready')
        return nil
    end

    local dict = GetPedheadshotTxdString(handle)
    if not LoadStreamedTextureDict(dict) then
        print(('[st_ipl] texture dict %q failed to load'):format(dict))
    end
    return dict
end

exports('GetPedheadshotTexture', GetPedheadshotTexture)
