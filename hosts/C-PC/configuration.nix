{ config, lib, pkgs, stylix, ... }:

{
  imports =
    [ 
      ../../modules/system/system.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "nfs"];

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
     font = "Lat2-Terminus16";
     keyMap = "et";
   };

  nixpkgs.config.allowUnfree = true;

  services.pipewire = {
     enable = true;
     wireplumber.enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };

   environment.systemPackages = with pkgs; [
     neovim
     killall
     alsa-plugins
     bluez
     libnotify
     font-awesome
     wget
     gcc
   ];

  security.pam.services.hyprlock = {};
  programs.nix-ld.enable = true; 
      
  fonts.packages = with pkgs; [
	noto-fonts
	adwaita-fonts
	nerd-fonts.jetbrains-mono
	noto-fonts-cjk-sans
  ];
  
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

