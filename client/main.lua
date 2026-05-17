local build <const> = GetGameBuildNumber()

---@param label string
---@param fn fun()
local function safe(label, fn)
    local ok, err = pcall(fn)
    if not ok then
        print(('[st_ipl] DLC %q load failed: %s'):format(label, tostring(err)))
    end
end

---@type table<string, fun()>
local DLC_LOADERS = {
    HighLife = function()
        HLApartment1.LoadDefault(); HLApartment2.LoadDefault(); HLApartment3.LoadDefault()
        HLApartment4.LoadDefault(); HLApartment5.LoadDefault(); HLApartment6.LoadDefault()
    end,
    Heists = function()
        HeistCarrier.Enable(true); HeistYacht.LoadDefault()
    end,
    Executive = function()
        ExecApartment1.LoadDefault(); ExecApartment2.LoadDefault(); ExecApartment3.LoadDefault()
    end,
    Finance = function()
        FinanceOffice1.LoadDefault(); FinanceOffice2.LoadDefault()
        FinanceOffice3.LoadDefault(); FinanceOffice4.LoadDefault()
    end,
    Bikers = function()
        BikerCocaine.LoadDefault(); BikerCounterfeit.LoadDefault()
        BikerDocumentForgery.LoadDefault(); BikerMethLab.LoadDefault()
        BikerWeedFarm.LoadDefault()
        BikerClubhouse1.LoadDefault(); BikerClubhouse2.LoadDefault()
    end,
    ImportExp = function()
        ImportCEOGarage1.LoadDefault(); ImportCEOGarage2.LoadDefault()
        ImportCEOGarage3.LoadDefault(); ImportCEOGarage4.LoadDefault()
        ImportVehicleWarehouse.LoadDefault()
    end,
    Gunrunning = function()
        GunrunningBunker.LoadDefault(); GunrunningYacht.LoadDefault()
    end,
    Smuggler   = function() SmugglerHangar.LoadDefault() end,
    Doomsday   = function() DoomsdayFacility.LoadDefault() end,
    AfterHours = function() AfterHoursNightclubs.LoadDefault() end,
    Casino = function()
        DiamondCasino.LoadDefault(); DiamondPenthouse.LoadDefault()
        DiamondArcade.LoadDefault(); DiamondArcadeBasement.LoadDefault()
    end,
    CayoPerico = function()
        CayoPericoNightclub.LoadDefault(); CayoPericoSubmarine.LoadDefault()
    end,
    Tuner = function()
        TunerGarage.LoadDefault(); TunerMethLab.LoadDefault(); TunerMeetup.LoadDefault()
    end,
    Security = function()
        MpSecurityGarage.LoadDefault(); MpSecurityMusicRoofTop.LoadDefault()
        MpSecurityStudio.LoadDefault(); MpSecurityBillboards.LoadDefault()
        MpSecurityOffice1.LoadDefault(); MpSecurityOffice2.LoadDefault()
        MpSecurityOffice3.LoadDefault(); MpSecurityOffice4.LoadDefault()
    end,
    Mpsum2 = function()
        CriminalEnterpriseSmeonFix.LoadDefault()
        CriminalEnterpriseVehicleWarehouse.LoadDefault()
        CriminalEnterpriseWarehouse.LoadDefault()
    end,
    DrugWars = function()
        DrugWarsFreakshop.LoadDefault(); DrugWarsGarage.LoadDefault(); DrugWarsLab.LoadDefault()
    end,
    Mercenaries = function()
        MercenariesClub.LoadDefault(); MercenariesLab.LoadDefault(); MercenariesFixes.LoadDefault()
    end,
    ChopShop = function()
        ChopShopCargoShip.LoadDefault(); ChopShopCartelGarage.LoadDefault()
        ChopShopLifeguard.LoadDefault(); ChopShopSalvage.LoadDefault()
    end,
    Bounties = function()
        SummerCarrier.LoadDefault(); SummerOffice.LoadDefault()
    end,
    Agents = function()
        AgentsFactory.LoadDefault(); AgentsOffice.LoadDefault()
        AgentsAirstrip.LoadDefault(); AgentsHangarDoor.LoadDefault()
    end,
    Money = function()
        MoneyCarwash.LoadDefault(); MoneyOffice.LoadDefault()
    end,
    Mansions = function()
        Mansion1.LoadDefault(); Mansion2.LoadDefault(); Mansion3.LoadDefault()
        MansionBasement1.LoadDefault(); MansionBasement2.LoadDefault(); MansionBasement3.LoadDefault()
    end,
}

CreateThread(function()
    if Config.Base then
        safe('base', function()
            Michael.LoadDefault()
            Simeon.LoadDefault()
            FranklinAunt.LoadDefault()
            Franklin.LoadDefault()
            Floyd.LoadDefault()
            TrevorsTrailer.LoadDefault()
        end)
    end

    if Config.Ammu         then safe('ammunations',   Ammunations.LoadDefault)   end
    if Config.Lester       then safe('lester',        LesterFactory.LoadDefault) end
    if Config.Stripclub    then safe('stripclub',     StripClub.LoadDefault)     end
    if Config.Cargoship    then safe('cargoship',     CargoShip.LoadDefault)     end
    if Config.Graffitis    then safe('graffitis',     function() Graffitis.Enable(true) end) end
    if Config.Pillbox      then safe('pillbox',       function() PillboxHospital.Enable(true) end) end
    if Config.ZancudoGates then safe('zancudo gates', ZancudoGates.LoadDefault)  end
    if Config.RedCarpet    then safe('red carpet',    function() RedCarpet.Enable(true) end) end
    if Config.Yankton      then safe('north yankton', function() NorthYankton.Enable(true) end) end

    if Config.UFO then
        safe('ufo', function()
            UFO.Hippie.Enable(true)
            UFO.Chiliad.Enable(true)
            UFO.Zancudo.Enable(true)
        end)
    end

    safe('bahama mamas', function() BahamaMamas.Enable(true) end)

    if Config.GtaOnline then
        safe('gta-online', function()
            GTAOApartmentHi1.LoadDefault(); GTAOApartmentHi2.LoadDefault()
            GTAOHouseHi1.LoadDefault();     GTAOHouseHi2.LoadDefault()
            GTAOHouseHi3.LoadDefault();     GTAOHouseHi4.LoadDefault()
            GTAOHouseHi5.LoadDefault();     GTAOHouseHi6.LoadDefault()
            GTAOHouseHi7.LoadDefault();     GTAOHouseHi8.LoadDefault()
            GTAOHouseMid1.LoadDefault();    GTAOHouseLow1.LoadDefault()
        end)
    end

    for key, loader in pairs(DLC_LOADERS) do
        local cfg = Config.DLC[key]
        if cfg and cfg.enabled and build >= (cfg.build or 0) then
            safe(key, loader)
        end
    end
end)
