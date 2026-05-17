local INTERIOR_SCAN_MS <const> = 500
local SAFE_SCAN_MS     <const> = 500

---@param mod st_ipl.IplModule?
---@return integer
local function moduleInteriorId(mod)
    if not mod then return 0 end
    return mod.interiorId or mod.currentInteriorId or mod.InteriorId or 0
end

---@type table<string, table<string, st_ipl.IplModule>>
local CHECKS = {
    Online = {
        isInsideApartmentHi1 = GTAOApartmentHi1,
        isInsideApartmentHi2 = GTAOApartmentHi2,
        isInsideHouseHi1     = GTAOHouseHi1,
        isInsideHouseHi2     = GTAOHouseHi2,
        isInsideHouseHi3     = GTAOHouseHi3,
        isInsideHouseHi4     = GTAOHouseHi4,
        isInsideHouseHi5     = GTAOHouseHi5,
        isInsideHouseHi6     = GTAOHouseHi6,
        isInsideHouseHi7     = GTAOHouseHi7,
        isInsideHouseHi8     = GTAOHouseHi8,
        isInsideHouseLow1    = GTAOHouseLow1,
        isInsideHouseMid1    = GTAOHouseMid1,
    },
    HighLife = {
        isInsideApartment1 = HLApartment1,
        isInsideApartment2 = HLApartment2,
        isInsideApartment3 = HLApartment3,
        isInsideApartment4 = HLApartment4,
        isInsideApartment5 = HLApartment5,
        isInsideApartment6 = HLApartment6,
    },
    Biker = {
        isInsideClubhouse1 = BikerClubhouse1,
        isInsideClubhouse2 = BikerClubhouse2,
    },
    FinanceOffices = {
        isInsideOffice1 = FinanceOffice1,
        isInsideOffice2 = FinanceOffice2,
        isInsideOffice3 = FinanceOffice3,
        isInsideOffice4 = FinanceOffice4,
    },
    Security = {
        isInsideOffice1 = MpSecurityOffice1,
        isInsideOffice2 = MpSecurityOffice2,
        isInsideOffice3 = MpSecurityOffice3,
        isInsideOffice4 = MpSecurityOffice4,
    },
}

---@class st_ipl.Global
Global = {
    currentInteriorId = 0,
    ResetInteriorVariables = function()
        for group in pairs(CHECKS) do
            for k in pairs(Global[group]) do Global[group][k] = false end
        end
    end,
}

for group, fields in pairs(CHECKS) do
    Global[group] = {}
    for field in pairs(fields) do Global[group][field] = false end
end

CreateThread(function()
    while true do
        local interiorId = GetInteriorFromEntity(cache.ped)
        Global.currentInteriorId = interiorId

        if interiorId == 0 then
            Global.ResetInteriorVariables()
        else
            for group, fields in pairs(CHECKS) do
                local bucket = Global[group]
                for field, mod in pairs(fields) do
                    bucket[field] = (interiorId == moduleInteriorId(mod))
                end
            end
        end

        Wait(INTERIOR_SCAN_MS)
    end
end)

---@type table<integer, string[]>
local SECURITY_CULL <const> = {
    [1] = { 'bh1_05_build1', 'bh1_05_em' },
    [2] = { 'hei_hw1_08_hotplaz01', 'hw1_08_hotplaz_rail', 'hw1_08_emissive_c' },
    [3] = { 'hei_kt1_05_01', 'kt1_05_glue_b', 'kt1_05_kt_emissive_kt1_05' },
    [4] = { 'hei_kt1_08_buildingtop_a', 'hei_kt1_08_kt1_emissive_ema' },
}

CreateThread(function()
    while true do
        local S = Global.Security
        local insideAny = S.isInsideOffice1 or S.isInsideOffice2 or S.isInsideOffice3 or S.isInsideOffice4

        if insideAny then
            for officeNum, models in pairs(SECURITY_CULL) do
                if S['isInsideOffice' .. officeNum] then
                    for _, model in ipairs(models) do
                        EnableExteriorCullModelThisFrame(joaat(model))
                    end
                end
            end
            DisableOcclusionThisFrame()
            Wait(0)
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        local F = Global.FinanceOffices
        local office =
            F.isInsideOffice1 and FinanceOffice1 or
            F.isInsideOffice2 and FinanceOffice2 or
            F.isInsideOffice3 and FinanceOffice3 or
            F.isInsideOffice4 and FinanceOffice4 or nil

        if office and office.Safe and office.currentSafeDoors then
            if office.Safe.GetDoorHandle(office.currentSafeDoors.hashL) ~= 0 then
                office.Safe.SetDoorState('left', office.Safe.isLeftDoorOpen and true or false)
            end
            if office.Safe.GetDoorHandle(office.currentSafeDoors.hashR) ~= 0 then
                office.Safe.SetDoorState('right', office.Safe.isRightDoorOpen and true or false)
            end
        end

        Wait(SAFE_SCAN_MS)
    end
end)
