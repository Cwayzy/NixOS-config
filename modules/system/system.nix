{ ... }:
{
  imports = [
    ./sddm/sddm.nix
    ./laptop-optimization/laptop-optimization.nix
    ./security/security.nix
    ./fingerprint/fingerprint.nix
    ./mount/mount.nix
    ./desktop/hyprland.nix
    ./desktop/plasma.nix
    ./audio/audio.nix
    ./bluetooth/bluetooth.nix
    ./gaming/gaming.nix
    ./flatpak/flatpak.nix
  ];
}
