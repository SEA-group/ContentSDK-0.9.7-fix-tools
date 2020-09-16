# ContentSDK fix toolkit

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/SEA-group/ContentSDK-0.9.7-fix-tools?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/SEA-group/ContentSDK-0.9.7-fix-tools)
![GitHub issues](https://img.shields.io/github/issues-raw/SEA-group/ContentSDK-0.9.7-fix-tools)
![GitHub downloads](https://img.shields.io/github/downloads/SEA-group/ContentSDK-0.9.7-fix-tools/total)

A fix tool for several contentSDK issues appeared since 0.9.7.0 patch

Note that this is a temporary solution proposed by MatroseFuchs from WG. [Main post](https://forum.worldofwarships.eu/topic/140165-primitive-group-issue)

Scripts by AstreTunes @ SEA group

## How to use
1. Put `LOD_transporter.m`, `Obsolete_node_remover.m` and `content_0.9.8.0.mat` in `[WoWS folder]/bin/[largest number]/res_mods/PnFMods/`
2. Run `LOD_transporter.m`
3. Run `Obsolete_node_remover.m`
4. Original *.visual* and *.model* files are backed up and renamed to **.visualbak* and **.modelbak*, if your mods work fine after the fix, you can consider remove those backup files.

### Attention
1. **Matlab version must be r2016b or later**
2. **The backup will be overwritten if you run the script twice**

**[Download](https://github.com/SEA-group/ContentSDK-0.9.7-fix-tools/releases/download/0.9.8.0/ContentSDK_fix_0.9.8.zip)**

## To generate content.mat after new game patch
1. Download [wowsunpack.exe](https://forum.worldofwarships.eu/topic/113847-all-wows-unpack-tool-unpack-game-client-resources/) and put it in WoWS installation folder;
2. Open cmd in the same folder, type `wowsunpack.exe -l -x bin\[build_number]\idx -p ..\..\..\res_packages -I content/gameplay/*/misc/* -I content/gameplay/*/technical/* -X *textures* -X *lod* > content.txt`; note that the build number changes according to game client version;
3. Put `content.txt` beside `Available_MP_nodes_check.m`, **check the version number in line 18**, and run the latter. The path of this script does not matter.
