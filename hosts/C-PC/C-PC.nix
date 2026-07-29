{ config, lib, pkgs, vars, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "C-PC";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEftiVariables = true;

  services.getty.autologinUser = vars.username;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  system.stateVersion = "26.05";
}
