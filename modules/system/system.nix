{ ... }:
{
  imports = [
    ./sddm/sddm.nix
    ./mount/mount.nix
    ./bluetooth/bluetooth.nix
  ];

  modules.system = {
    sddm = {
      enable = true;
      autolign = true;
    };
    mount.enable = true;
    bluetooth.enable = true;
  };
}
