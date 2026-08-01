{ ... }:
{
  imports = [
    ./sddm/sddm.nix
    ./security/security.nix
    ./fingerprint/fingerprint.nix
    ./mount/mount.nix
    ./hyprland/hyprland.nix
    ./bluetooth/bluetooth.nix
    ./gaming/gaming.nix
  ];
}
