{ ... }:
{
  imports = [
    ./bluetooth/bluetooth.nix
    ./mount/mount.nix
    ./greetd/greetd.nix
  ];

  modules.system = {
    greetd.enable = true;
    mount.enable = true;
    bluetooth.enable = true;
  };
}
