# Obsolete MP nodes remover

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/SEA-group/Obsolete-MP-nodes-remover?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/SEA-group/Obsolete-MP-nodes-remover)
![GitHub issues](https://img.shields.io/github/issues-raw/SEA-group/Obsolete-MP-nodes-remover)
![GitHub downloads](https://img.shields.io/github/downloads/SEA-group/Obsolete-MP-nodes-remover/total)

By AstreTunes @ SEA group

## How to use
1. Put `Obsolete_node_remover.m` and `content.mat` in `[WoWS folder]/bin/[largest number]/res_mods/PnFMods/`
2. Run `Obsolete_node_remover.m`
3. Original *.visual* files are backed up and renamed to **.visualbak*

### Attention
1. **Matlab version must be r2016b or later**
2. **The backup will be overwritten if you run the script twice**

**[Download](https://github.com/SEA-group/Obsolete-MP-nodes-remover/archive/Script_for_0.9.7.0.zip)**

## To generate content.mat after new game patch
1. Download [wowsunpack.exe](https://forum.worldofwarships.eu/topic/113847-all-wows-unpack-tool-unpack-game-client-resources/) and put it in WoWS installation folder;
2. Open cmd in the same folder, type `wowsunpack.exe -l -x bin\[build_number]\idx -p ..\..\..\res_packages -I content/gameplay/*/misc/* -I content/gameplay/*/technical/* -X *textures* -X *lod* > content.txt`; note that the build number changes according to game client version;
3. Put `content.txt` beside `Available_MP_nodes_check.m`, **check the version number in line 18**, and run the latter. The path of this script does not matter.
