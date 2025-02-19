## vpxinstaller

This project provides setup instructions for VPX Standalone on Steam Deck.
The included script performs the following installation steps automatically, and generates a Konsole launcher for vpxtool which can be added to Steam.
To use the script, download or copy `InstallVPX.sh` from the repo then make sure it is executable in file permissions and run it in Konsole.

## [Visual Pinball X](https://github.com/vpinball/vpinball/):
- Download the linux-x64 release [package](https://github.com/vpinball/vpinball/releases).

- Extract the tar.gz file contents to directory of your choice. Rename the output folder for legibility.

    `/home/deck/VPinballX`

- Place table files in the game's tables directory. PinMAME roms can be added by manually creating the subdirectory.

    `/home/deck/VPinballX/tables/pinmame/roms`

- Tables can now be launched individually from the terminal, or by adding the target to Steam. To select from an index, use vpxtool instead.

    `VPinballX_GL -play "tables/[name]"`


## [vpxtool](https://github.com/francisdb/vpxtool):
- Download the Linux-x86_64 release [package](https://github.com/francisdb/vpxtool/releases).

- Extract contents to the VPX directory.

    `/home/deck/VPinballX/vpxtool`

- Run the config setup command inside the same directory.

    `./vpxtool config setup`

- vpxtool can now be launched from the terminal, allowing to select and play tables from an auto generated index.

    `./vpxtool frontend`

- Use a bash script to lauch vpxtool.

    ```
    #!/bin/bash
    konsole -e "./vpxtool frontend"
    ```

- Add the launch script to Steam.

    `/home/deck/VPinballX/launch.sh`


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


## Troubleshooting

-  Note that analog stick tilt and trigger inputs are currently causing some physics issues and should be disabled.

-  For tables which don't automatically display the DMD, information can be found in the VPX Standalone [Readme](https://github.com/vpinball/vpinball/blob/master/standalone/README.md#my-game-is-not-displaying-a-dmd)

-  For tables which produce a script error when launching, check out [vpx-standalone-scripts](https://github.com/jsm174/vpx-standalone-scripts)

-  If vpxtool reports missing nvram for working PinMAME tables, select "Force reload" from the table launch menu.
