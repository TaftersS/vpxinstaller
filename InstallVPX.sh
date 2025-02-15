#!/bin/bash

# Prompt user for installation directory or use default
default_dir="$HOME/VPinballX"
echo "Enter installation directory (Press enter to use default: $default_dir):"
read install_dir
INSTALL_DIR=${install_dir:-$default_dir}

VPX_URL="https://github.com/vpinball/vpinball/releases/download/v10.8.0-2051-28dd6c3/VPinballX_GL-10.8.0-2052-5a81d4e-Release-linux-x64.zip"
VPXTOOL_URL="https://github.com/francisdb/vpxtool/releases/download/v0.19.1/vpxtool-Linux-x86_64-musl-v0.19.1.tar.gz"

# Create the installation directory
mkdir -p "$INSTALL_DIR/tables/pinmame/roms"

# Download and extract Visual Pinball X
echo "Downloading Visual Pinball X..."
wget -O /tmp/vpx.zip "$VPX_URL"
echo "Extracting zip file..."
unzip /tmp/vpx.zip -d /tmp/vpx_extracted

# Create directory for tar.gz extraction
mkdir -p /tmp/vpx_extracted_contents

echo "Extracting tar.gz file..."
tar -xzf /tmp/vpx_extracted/*.tar.gz -C /tmp/vpx_extracted_contents

echo "Moving extracted files..."
mv /tmp/vpx_extracted_contents/* "$INSTALL_DIR"
rm -r /tmp/vpx.zip /tmp/vpx_extracted /tmp/vpx_extracted_contents

echo "Visual Pinball X installed to $INSTALL_DIR"

# Run VPinballX_GL to configure VPX
echo "Configuring Visual Pinball X..."
cd "$INSTALL_DIR" && ./VPinballX_GL

# Download and extract vpxtool (optional)
echo "Downloading vpxtool..."
wget -O /tmp/vpxtool.tar.gz "$VPXTOOL_URL"
echo "Extracting..."
mkdir -p "$INSTALL_DIR/vpxtool"
tar -xzf /tmp/vpxtool.tar.gz -C "$INSTALL_DIR"
rm /tmp/vpxtool.tar.gz

echo "Running vpxtool setup..."
cd "$INSTALL_DIR" && ./vpxtool config setup

echo "vpxtool installed and configured."

# Create launch script for vpxtool
LAUNCH_SCRIPT="$INSTALL_DIR/launch.sh"
echo "Creating launch script..."
cat <<EOL > "$LAUNCH_SCRIPT"
#!/bin/bash
konsole -e "./vpxtool simplefrontend"
EOL
chmod +x "$LAUNCH_SCRIPT"

echo "Launch script created at $LAUNCH_SCRIPT. You can add this script to Steam."

echo "Setup complete!"

# Prompt the user before closing
read -p "Press Enter to close..."