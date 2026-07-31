{ config, lib, pkgs, vars, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "C-HP";
	
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.resumeDevice = "/dev/mapper/cryptroot";
  boot.kernelParams = [ "resume_offset=2630912"];

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "render" ];
    packages = with pkgs; [
      tree
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "26.05";
}
