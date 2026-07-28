#!/usr/bin/env bash
set -e

GITHUB_USER="Cwayzy"
REPO_NAME="NixOS-config"
TARGET_HOST="C_PC"
TARGET_USER="kevin"
TARGET_DISK="${1:-/dev/sda}"

echo "====================================================="
echo " WARNING: THIS WILL FULLY ERASE AND REBUILD $TARGET_DISK "
echo "====================================================="
read -p "Are you sure you want to completely rebuild? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

# 1. Download Dotfiles to temporary directory
echo "==> Fetching repository..."
TMP_DIR=$(mktemp -d)
git clone "https://github.com/${GITHUB_USER}/${REPO_NAME}.git" "$TMP_DIR"

# 2. Partition & Format Disk with Disko
echo "==> Partitioning and formatting disk $TARGET_DISK..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
  --mode disko "$TMP_DIR/disk-config.nix" --argstr device "\"$TARGET_DISK\""

# 3. Transfer Dotfiles to installed location
TARGET_DOTFILES="/mnt/home/${TARGET_USER}/.dotfiles"
echo "==> Placing dotfiles into $TARGET_DOTFILES..."
mkdir -p "$TARGET_DOTFILES"
cp -r "$TMP_DIR/." "$TARGET_DOTFILES/"
chown -R 1000:1000 "/mnt/home/${TARGET_USER}"

# 4. Generate Hardware Config if missing
if [ ! -f "$TARGET_DOTFILES/hardware-configuration.nix" ]; then
  echo "==> Generating hardware configuration..."
  nixos-generate-config --root /mnt
  cp /mnt/etc/nixos/hardware-configuration.nix "$TARGET_DOTFILES/hardware-configuration.nix"
fi

# 5. Install NixOS
echo "==> Installing NixOS..."
nixos-install --flake "$TARGET_DOTFILES#$TARGET_HOST" --no-root-password

# 6. Bootstrap Standalone Home Manager
echo "==> Applying Standalone Home Manager..."
nixos-enter --root /mnt -- su - "$TARGET_USER" -c "
  cd ~/.dotfiles
  nix run github:nix-community/home-manager -- switch --flake .#$TARGET_USER
"

echo "====================================================="
echo " Full System Rebuild Complete! Remove USB and reboot. "
echo "====================================================="
