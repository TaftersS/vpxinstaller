#!/bin/bash

set -e

# Fetch latest vpxtool release URL dynamically
VPXTOOL_URL=$(curl -s https://api.github.com/repos/francisdb/vpxtool/releases/latest | grep "browser_download_url.*Linux-x86_64-musl.*.tar.gz" | cut -d '"' -f 4)

# Prompt user for installation directory or use default
default_dir="$HOME/VPinballX"
echo "Enter installation directory (Press enter to use default: $default_dir):"
read install_dir
INSTALL=${install_dir:-$default_dir}

echo "Installing to: $INSTALL"

mkdir -p "$INSTALL"

echo "Finding VPinballX zip..."
VPX_ZIP=$(find . -name 'VPinballX_BGFX*.zip' -type f | head -1)

if [ -z "$VPX_ZIP" ]; then
    echo "ERROR: Could not find VPinballX_BGFX zip in current directory."
    exit 1
fi

cp "$VPX_ZIP" /tmp/vpx.zip

echo "Extracting zip file..."
rm -rf /tmp/vpx_extracted
mkdir -p /tmp/vpx_extracted
unzip /tmp/vpx.zip -d /tmp/vpx_extracted

mkdir -p /tmp/vpx_extracted_contents

echo "Extracting tar.gz file..."
tar -xzf /tmp/vpx_extracted/*.tar.gz -C /tmp/vpx_extracted_contents

echo "Moving extracted files..."
mv /tmp/vpx_extracted_contents/* "$INSTALL"

mkdir -p "$INSTALL/tables"

rm -rf /tmp/vpx.zip /tmp/vpx_extracted /tmp/vpx_extracted_contents

echo "Visual Pinball X installed to $INSTALL"

# Run VPinballX_BGFX once to generate configs
echo "Launching Visual Pinball X for first time..."
cd "$INSTALL"
./VPinballX_BGFX || true

# Download vpxtool
echo "Downloading vpxtool..."
wget -O /tmp/vpxtool.tar.gz "$VPXTOOL_URL"

echo "Extracting vpxtool..."
tar -xzf /tmp/vpxtool.tar.gz -C "$INSTALL"

rm /tmp/vpxtool.tar.gz

# Create vpxtool.cfg in install directory
echo "Creating vpxtool.cfg..."

cat <<EOL > "$INSTALL/vpxtool.cfg"
vpx_executable = "$INSTALL/VPinballX_BGFX"
vpx_config = "$HOME/.vpinball/VPinballX.ini"
tables_folder = "$INSTALL/tables"

[[launch_templates]]
name = "Launch"
executable = "$INSTALL/VPinballX_BGFX"

[[launch_templates]]
name = "Launch Fullscreen"
executable = "$INSTALL/VPinballX_BGFX"
arguments = ["-EnableTrueFullscreen"]

[[launch_templates]]
name = "Launch Windowed"
executable = "$INSTALL/VPinballX_BGFX"
arguments = ["-DisableTrueFullscreen"]
EOL

echo "vpxtool.cfg created."

# Run vpxtool setup
echo "Running vpxtool setup..."
cd "$INSTALL"
./vpxtool config setup || true

# Create uninstall script
echo "Creating uninstall script..."

cat <<EOL > "$INSTALL/uninstall.sh"
#!/bin/bash

echo "WARNING - The following paths will be removed:"
echo "$INSTALL"
echo "$HOME/.config/vpxtool.cfg"
echo "$HOME/.vpinball"

read -p "Are you sure you want to uninstall Visual Pinball X and vpxtool? (y/n): " confirm

if [[ "\$confirm" != "y" ]]; then
    echo "Uninstallation cancelled."
    exit 1
fi

echo "Removing files..."

rm -rf "$INSTALL"
rm -rf "$HOME/.config/vpxtool.cfg"
rm -rf "$HOME/.vpinball"

echo "Uninstallation complete."
read -p "Press enter to exit."
EOL

chmod +x "$INSTALL/uninstall.sh"

# Create Steam launch script
LAUNCH_SCRIPT="$INSTALL/launch.sh"

echo "Creating launch script..."

cat <<EOL > "$LAUNCH_SCRIPT"
#!/bin/bash
cd "$INSTALL"
konsole -e "./vpxtool frontend"
EOL

chmod +x "$LAUNCH_SCRIPT"

echo
echo "Installation complete!"
echo
echo "VPX installed to: $INSTALL"
echo "Launch script: $LAUNCH_SCRIPT"
echo
echo "You can add launch.sh to Steam."

read -p "Press enter to exit."
