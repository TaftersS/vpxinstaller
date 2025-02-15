This project provides setup instructions for VPX Standalone[https://github.com/vpinball/vpinball/] on Steam Deck.
The included script performs installation steps automatically, and generates a Konsole launcher.

Visual Pinball X:
- Download the linux-x64 release package.
    https://github.com/vpinball/vpinball/releases

- Extract the tar.gz file contents to directory of your choice. I would advise to rename the output folder for legibility.
    </home/deck/VPinballX>

- Place table files in the game's tables directory. PinMAME roms can be added by manually creating the subdirectory.
    </home/deck/VPinballX/tables/pinmame/roms>

- Tables can be launched individually from the terminal, or by adding the target to Steam. To select from an index, use vpxtool instead.
    <VPinballX_GL -play "tables/[name]>


vpxtool (optional):
- Download the Linux-x86_64 release package.
    https://github.com/francisdb/vpxtool/releases

- Extract contents to the VPX directory.
    </home/deck/VPinballX/>

- Run the config setup command.
    <vpxtool config setup>

- vpxtool can now be launched from the terminal, allowing to select and play tables from an automatically generated index.
    <vpxtool frontend>

- Use a bash script to lauch vpxtool. (optional)
    #!/bin/bash
    <konsole -e "./vpxtool simplefrontend">

- Add the launch script to Steam. (optional)
    </home/deck/VPinballX/launch.sh>