{ config, lib, pkgs, vars, ...}:
let
  cfg = config.modules.system.virtualisation;
in
{
  options.modules.system.virtualisation = {
    enable = lib.mkEnableOption "libvirt/KVM virtual machine";
  };

  config = lib.mkIf cfg.enable {
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

    user.users.${vars.username}.extraGroups = [ "libvirtd" ];
  };
}
