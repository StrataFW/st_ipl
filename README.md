# st_ipl

Interior loader for Strata. Activates the IPLs and entity sets that GTA V
ships disabled — apartments, offices, clubhouses, casinos, mansions, and
the rest of the DLC interior catalog — so they're visitable on a FiveM
server.

Framework code is Strata-authored. Per-DLC data tables under `data/` are
derived from [**bob74_ipl**](https://github.com/Bob-74/bob74_ipl) by
**Bob_74** (MIT) — see [`NOTICE.md`](./NOTICE.md) and
[`LICENSE.bob74`](./LICENSE.bob74).

**What you get:**

- On resource start, every enabled DLC + base-game interior group activates
  from `shared/config.lua`. DLCs whose `build` requirement exceeds the
  live `sv_enforceGameBuild` are skipped automatically.
- Canonical bob74-style globals (`EnableIpl`, `SetIplPropState`,
  `Global.currentInteriorId`, per-DLC `isInsideX` flags) so any resource
  written against the upstream API works unchanged.
- Each DLC loader wrapped in `pcall` — one broken interior can't take down
  the rest of the load.
- Background threads keep `Global.currentInteriorId` + the `isInside*`
  flags in sync, drive the Security DLC exterior-cull frame tick, and
  poll the Finance office safe doors.
- `GetPedheadshotTexture` export for downstream Finance signage and a
  couple of biker scaleforms.

## Setup

1. Drop the resource into `resources/[strata]/st_ipl/`.
2. In `server.cfg`:
   ```
   ensure st_ipl
   ```
   Start it before any resource that depends on a DLC interior being loaded.

## Configuration

All runtime config lives in `shared/config.lua`. Highlights:

| Field                                              | Purpose                                                            |
|----------------------------------------------------|--------------------------------------------------------------------|
| `Base` / `GtaOnline` / `Ammu` / `Pillbox` / `Stripclub` / `Cargoship` / `Graffitis` / `Lester` / `ZancudoGates` | Base-game interior groups (default `true`).                        |
| `RedCarpet` / `Yankton` / `UFO`                    | Off by default — flip on for the niche groups.                     |
| `DLC[<name>] = { enabled, build }`                 | Per-DLC enable + minimum `sv_enforceGameBuild` gate.               |

If the running server is below an entry's `build`, the loader skips it
rather than crashing on missing IPL names.

## Globals provided

Matches upstream bob74_ipl so existing data drops in unchanged:

```lua
EnableIpl(ipl, activate)                              -- activate or strip an IPL by name
SetIplPropState(interiorId, props, state, refresh)    -- toggle entity sets

Global.currentInteriorId                              -- live-updated player interior id
Global.Online.isInsideApartmentHi1                    -- per-DLC presence flags
Global.HighLife.isInsideApartment1                    -- (etc.)
```

## Exports

| Export                  | Use                                                |
|-------------------------|----------------------------------------------------|
| `EnableIpl`             | activate/deactivate an IPL by name                 |
| `SetIplPropState`       | toggle an interior's entity set(s)                 |
| `GetPedheadshotTexture` | register + load a ped's headshot, returns the dict |

## Layout

```
st_ipl/
├── fxmanifest.lua
├── shared/
│   ├── types.lua          ---@meta type aliases (DLCFlag, IplModule, …)
│   └── config.lua         per-DLC enable + min-build toggles
├── client/
│   ├── util.lua           scaleform / rendertarget / headshot helpers
│   ├── loader.lua         EnableIpl + SetIplPropState primitives
│   ├── observers.lua      current-interior + per-DLC isInside flags
│   └── main.lua           entry — walks Config, fires each loader
└── data/
    ├── gtav/              base map (Michael, Franklin, ammunations, …)
    ├── gta_online/        online apartments + houses
    ├── dlc_high_life/     High Life apartments
    ├── dlc_heists/        Heists (carrier, yacht)
    ├── dlc_executive/     Executives & Other Criminals
    ├── dlc_finance/       Finance & Felony offices
    ├── dlc_bikers/        Bikers (clubhouses, businesses)
    ├── dlc_import/        Import/Export (CEO garages, warehouse)
    ├── dlc_gunrunning/    Gunrunning bunkers, yacht
    ├── dlc_smuggler/      Smuggler's Run hangar
    ├── dlc_doomsday/      Doomsday facility
    ├── dlc_afterhours/    After Hours nightclubs
    ├── dlc_casino/        Diamond Casino + penthouse + arcade
    ├── dlc_cayoperico/    Cayo Perico
    ├── dlc_tuner/         Tuners
    ├── dlc_security/      The Contract (studio, agency, billboards)
    ├── gta_mpsum2/        Criminal Enterprise
    ├── dlc_drugwars/      Drug Wars
    ├── dlc_mercenaries/   Mercenaries
    ├── dlc_chopshop/      Chop Shop
    ├── dlc_bounties/      Bottom Dollar Bounties
    ├── dlc_agents/        Agents of Sabotage
    ├── dlc_money/         Money Fronts
    └── dlc_mansions/      A Safehouse in the Hills
```

Uses ox_lib helpers throughout — `lib.waitFor`, `lib.requestScaleformMovie`,
`lib.requestStreamedTextureDict`, `cache.ped`.

## Dependencies

- `ox_lib` — `cache`, `waitFor`, asset request helpers

## Attribution

The IPL identifier strings and prop names are reverse-engineered from
Rockstar's game files; attribution to **Bob_74** is for the curation work
of compiling them into a maintainable data set. If you redistribute,
keep `LICENSE.bob74` and `NOTICE.md` intact.

## License

MIT — see [`LICENSE`](./LICENSE) (Strata loader) and
[`LICENSE.bob74`](./LICENSE.bob74) (upstream data).
