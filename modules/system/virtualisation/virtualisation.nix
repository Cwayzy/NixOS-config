{ config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.modules.nixos.virtualisation = { pkgs, ... }: {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    users.users.${username}.extraGroups = [ "libvirtd" ];
  };
}
