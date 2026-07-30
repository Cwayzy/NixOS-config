{ config, lib, pkgs, vars, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "C-HP";
	
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  system.stateVersion = "26.05";
}
