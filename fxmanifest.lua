fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'st_ipl'
author 'Strata Framework (loader); IPL data derived from bob74_ipl by Bob_74 (MIT)'
description 'Strata IPL loader. Owns the framework; data tables credited in NOTICE.md.'
version '1.0.0'
repository 'https://github.com/StrataFW/st_ipl'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/types.lua',
    'shared/config.lua',
}

client_scripts {
    'client/util.lua',
    'client/loader.lua',

    'data/gtav/base.lua',
    'data/gtav/ammunations.lua',
    'data/gtav/bahama.lua',
    'data/gtav/cargoship.lua',
    'data/gtav/floyd.lua',
    'data/gtav/franklin.lua',
    'data/gtav/franklin_aunt.lua',
    'data/gtav/graffitis.lua',
    'data/gtav/lester_factory.lua',
    'data/gtav/michael.lua',
    'data/gtav/north_yankton.lua',
    'data/gtav/pillbox_hospital.lua',
    'data/gtav/red_carpet.lua',
    'data/gtav/simeon.lua',
    'data/gtav/stripclub.lua',
    'data/gtav/trevors_trailer.lua',
    'data/gtav/ufo.lua',
    'data/gtav/zancudo_gates.lua',

    'data/gta_online/apartment_hi_1.lua',
    'data/gta_online/apartment_hi_2.lua',
    'data/gta_online/house_hi_1.lua',
    'data/gta_online/house_hi_2.lua',
    'data/gta_online/house_hi_3.lua',
    'data/gta_online/house_hi_4.lua',
    'data/gta_online/house_hi_5.lua',
    'data/gta_online/house_hi_6.lua',
    'data/gta_online/house_hi_7.lua',
    'data/gta_online/house_hi_8.lua',
    'data/gta_online/house_low_1.lua',
    'data/gta_online/house_mid_1.lua',

    'data/dlc_high_life/apartment1.lua',
    'data/dlc_high_life/apartment2.lua',
    'data/dlc_high_life/apartment3.lua',
    'data/dlc_high_life/apartment4.lua',
    'data/dlc_high_life/apartment5.lua',
    'data/dlc_high_life/apartment6.lua',

    'data/dlc_heists/carrier.lua',
    'data/dlc_heists/yacht.lua',

    'data/dlc_executive/apartment1.lua',
    'data/dlc_executive/apartment2.lua',
    'data/dlc_executive/apartment3.lua',

    'data/dlc_finance/office1.lua',
    'data/dlc_finance/office2.lua',
    'data/dlc_finance/office3.lua',
    'data/dlc_finance/office4.lua',
    'data/dlc_finance/organization.lua',

    'data/dlc_bikers/cocaine.lua',
    'data/dlc_bikers/counterfeit_cash.lua',
    'data/dlc_bikers/document_forgery.lua',
    'data/dlc_bikers/meth.lua',
    'data/dlc_bikers/weed.lua',
    'data/dlc_bikers/clubhouse1.lua',
    'data/dlc_bikers/clubhouse2.lua',
    'data/dlc_bikers/gang.lua',

    'data/dlc_import/garage1.lua',
    'data/dlc_import/garage2.lua',
    'data/dlc_import/garage3.lua',
    'data/dlc_import/garage4.lua',
    'data/dlc_import/vehicle_warehouse.lua',

    'data/dlc_gunrunning/bunkers.lua',
    'data/dlc_gunrunning/yacht.lua',

    'data/dlc_smuggler/hangar.lua',

    'data/dlc_doomsday/facility.lua',

    'data/dlc_afterhours/nightclubs.lua',

    'data/dlc_casino/casino.lua',
    'data/dlc_casino/penthouse.lua',
    'data/dlc_casino/arcade.lua',
    'data/dlc_casino/arcade_basement.lua',

    'data/dlc_cayoperico/base.lua',
    'data/dlc_cayoperico/nightclub.lua',
    'data/dlc_cayoperico/submarine.lua',

    'data/dlc_tuner/garage.lua',
    'data/dlc_tuner/meetup.lua',
    'data/dlc_tuner/methlab.lua',

    'data/dlc_security/studio.lua',
    'data/dlc_security/billboards.lua',
    'data/dlc_security/musicrooftop.lua',
    'data/dlc_security/garage.lua',
    'data/dlc_security/office1.lua',
    'data/dlc_security/office2.lua',
    'data/dlc_security/office3.lua',
    'data/dlc_security/office4.lua',

    'data/gta_mpsum2/simeonfix.lua',
    'data/gta_mpsum2/vehicle_warehouse.lua',
    'data/gta_mpsum2/warehouse.lua',

    'data/dlc_drugwars/base.lua',
    'data/dlc_drugwars/freakshop.lua',
    'data/dlc_drugwars/garage.lua',
    'data/dlc_drugwars/lab.lua',
    'data/dlc_drugwars/traincrash.lua',

    'data/dlc_mercenaries/club.lua',
    'data/dlc_mercenaries/lab.lua',
    'data/dlc_mercenaries/fixes.lua',

    'data/dlc_chopshop/base.lua',
    'data/dlc_chopshop/cargoship.lua',
    'data/dlc_chopshop/cartel_garage.lua',
    'data/dlc_chopshop/lifeguard.lua',
    'data/dlc_chopshop/salvage.lua',

    'data/dlc_bounties/base.lua',
    'data/dlc_bounties/carrier.lua',
    'data/dlc_bounties/office.lua',

    'data/dlc_agents/base.lua',
    'data/dlc_agents/factory.lua',
    'data/dlc_agents/office.lua',
    'data/dlc_agents/airstrip.lua',
    'data/dlc_agents/hangar_door.lua',

    'data/dlc_money/base.lua',
    'data/dlc_money/carwash.lua',
    'data/dlc_money/office.lua',
    'data/dlc_money/construction.lua',

    'data/dlc_mansions/base.lua',
    'data/dlc_mansions/mansion1.lua',
    'data/dlc_mansions/mansion2.lua',
    'data/dlc_mansions/mansion3.lua',
    'data/dlc_mansions/mansion_basement1.lua',
    'data/dlc_mansions/mansion_basement2.lua',
    'data/dlc_mansions/mansion_basement3.lua',

    'client/observers.lua',
    'client/main.lua',
}

dependencies {
    'ox_lib',
}
