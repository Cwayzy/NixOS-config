{ config, lib, pkgs, stylix, ... }:

{
  imports = [ 
    ../../modules/system/system.nix
  ];

  modules.system = {
    sddm = {
      enable = true;
      autologin = true;
    };

    laptop-optimization.enable = true;
    security.enable = true;
    fingerprint.enable = true;
    mount.enable = true;
    hyprland.enable = true;
    bluetooth.enable = true;
    gaming.enable = false;
    flatpak.enable = true;
    openlp.enable = true;
  }; 

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
     brave
     neovim
     killall
     alsa-plugins
     bluez
     libnotify
     font-awesome
     wget
     gcc
     networkmanagerapplet
   ];
  programs.firefox.enable = true;
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

