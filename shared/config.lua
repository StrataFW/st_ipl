---@class st_ipl.Config
Config = {}

Config.Base         = true
Config.GtaOnline    = true
Config.Ammu         = true
Config.Pillbox      = true
Config.Stripclub    = true
Config.Cargoship    = true
Config.Graffitis    = true
Config.Lester       = true
Config.ZancudoGates = true

Config.RedCarpet    = false
Config.Yankton      = false
Config.UFO          = false

---@type table<string, st_ipl.DLCFlag>
Config.DLC = {
    HighLife    = { enabled = true,  build = 0    },
    Heists      = { enabled = true,  build = 0    },
    Executive   = { enabled = true,  build = 0    },
    Finance     = { enabled = true,  build = 0    },
    Bikers      = { enabled = true,  build = 0    },
    ImportExp   = { enabled = true,  build = 0    },
    Gunrunning  = { enabled = true,  build = 0    },
    Smuggler    = { enabled = true,  build = 0    },
    Doomsday    = { enabled = true,  build = 0    },
    AfterHours  = { enabled = true,  build = 0    },
    Casino      = { enabled = true,  build = 2060 },
    CayoPerico  = { enabled = true,  build = 2189 },
    Tuner       = { enabled = true,  build = 2372 },
    Security    = { enabled = true,  build = 2545 },
    Mpsum2      = { enabled = true,  build = 2699 },
    DrugWars    = { enabled = true,  build = 2802 },
    Mercenaries = { enabled = true,  build = 2944 },
    ChopShop    = { enabled = true,  build = 3095 },
    Bounties    = { enabled = true,  build = 3258 },
    Agents      = { enabled = true,  build = 3407 },
    Money       = { enabled = true,  build = 3570 },
    Mansions    = { enabled = true,  build = 3717 },
}
