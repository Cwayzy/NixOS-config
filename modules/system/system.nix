{ ... }:
{
  imports = [
    #./sddm/sddm.nix
    ./mount/mount.nix
    ./bluetooth/bluetooth.nix
  ];

  modules.system = {
    #sddm = {
    #  enable = true;
    #  autologin = true;
    #};

    mount.enable = true;
    bluetooth.enable = true;
  };
}
