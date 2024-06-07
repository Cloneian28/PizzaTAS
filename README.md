## PizzaTAS ##

<p>This repository contains all the source code for PizzaTAS<br>
Releases can be found here: https://github.com/Cloneian28/PizzaTAS/releases/<br>
Or alternatively, you can find them at Gamebanana: https://gamebanana.com/tools/17099<p>

## Instalation ##
To install this tool, you can use Pizza Oven to install it using the mod browser

Otherwise, heres how to install it manually:
- Get an XDelta Patcher (such as Delta Patcher or XDelta3 GUI)
- Download PizzaTAS.zip from either the gamebanana page or the releases page
- Extract it and put tastool.xdelta somewhere nice
- Open your XDelta Patcher
- Navigate to your Pizza Tower instalation folder (on steam you can find this by right clicking the game on your library and clicking "Manage Files"
- Select the data.win file as the original file and the tastool.xdelta file as the patch
- If you get an error after this step, your game is either already modded or not the right version

Setting up the settings:
- Download the TASConfig.zip file from either the gamebanana page or the releases page
- Extract it then put the files you get in your PizzaTower_GM2 folder (on windows, you can find this folder by pressing Win+R, typing %appdata%, then navigating to it
- After that, open the tasconfig.ini file and tweak the settings as you need to

## Usage ##
<p>PizzaTAS is best used along with libTAS because of the useful info it provides and its ability to record inputs to later playback in game</p>

There are 3 modes you can use to control how the tool behaves (defined in tasconfig.ini):
- 0: The default mode, recommended when just TASing the game
- 1: Recording, useful for recording libTAS TASes to later play back with audio
- 2: Playback, loads the tas specified in tasconfig.ini then plays it back

Keybindings:
- F6: Saves the tas to the path specified in tasconfig.ini
- P: Freezes the game until it is pressed again

## Credits ##
UndertaleModTool: Thing that let me make this in the first place

Celeste Input History: For the design of the input display
