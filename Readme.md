## Description

This project provides an installation shell script for [Visual Pinball X](https://github.com/vpinball/vpinball/) on Steam Deck.
The included script generates an uninstaller (uninstall.sh) and Konsole launcher for [vpxtool](https://github.com/francisdb/vpxtool) which can be added to Steam (launch.sh).

## Installation

- Copy or download [InstallVPX.sh](https://github.com/M0J0144/vpxinstaller/blob/main/InstallVPX.sh).

- Grant the installer executable permission in file properties.

- Run the installer in Konsole, and follow the prompts (press enter for defaults).

- Copy table and ROM files to your chosen directory.

- When finished, add the launch script to Steam.

    `VPinballX/launch.sh`

## Controller Configuration

- My personal configuration can be found in Steam's community layouts by changing the game's name to "Visual Pinball". Alternatively, you can create your own by mapping to keyboard inputs using Steam's configuration overlay.

    Here are some of the default keyboard controls for reference:
    ```
    Left flipper = Left shift
    Right flipper = Right shift
    Insert coin = 5
    Start game = 1
    Plunger = Enter
    Pause menu = Escape
    Quit = Q
    Nudge right = Z
    Nudge left = /
    Nudge forward = Space
    Mechanical tilt = T
    ```
    Navigate vpxtool using up/down arrow and enter/esc keys.

## Uninstallation

- Run the uninstall script in Konsole.

    `VPinballX/uninstall.sh`

## Troubleshooting

- Note that analog stick tilt and trigger inputs are currently causing some physics issues and should be disabled.

- For tables which don't automatically display the DMD, information can be found in the VPX Standalone [Readme](https://github.com/vpinball/vpinball/blob/master/standalone/README.md#my-game-is-not-displaying-a-dmd)

- For tables which produce a script error when launching, check out [vpx-standalone-scripts](https://github.com/jsm174/vpx-standalone-scripts)

- If vpxtool reports missing nvram for working PinMAME tables, select "Force reload" from the table launch menu.
