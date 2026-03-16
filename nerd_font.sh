# Install Iosevka Nerd Font to /usr/local/share/fonts

FONT_DIR="/usr/local/share/fonts/iosevka-nerd"
TMP_FILE="/tmp/iosevka-nerd.tar.xz"

# download
curl -L -o "$TMP_FILE" \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.tar.xz

# create font directory
sudo mkdir -p "$FONT_DIR"

# extract
sudo tar -xJf "$TMP_FILE" -C "$FONT_DIR"

# refresh font cache
fc-cache -f -v
