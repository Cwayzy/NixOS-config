{ ... }:
{
  imports = [
    ./sddm/sddm.nix
    ./mount/mount.nix
    ./hyprland/hyprland.nix
    ./bluetooth/bluetooth.nix
  ];

  modules.system = {
    sddm = {
      enable = true;
      autologin = true;
    };

    mount.enable = true;
    hyprland.enable = true;
    bluetooth.enable = true;
  };
}
