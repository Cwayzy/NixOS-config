{ config, lib, pkgs, stylix, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/system/system.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # nfs support
  boot.supportedFilesystems = [ "nfs"];

  # Networking
  networking.hostName = "C-PC";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  # Localization
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  # Console
  console = {
     font = "Lat2-Terminus16";
     keyMap = "et";
   };

  # User account
  services.getty.autologinUser = "kevin";

  users.users.kevin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      tree
    ];
  };
  
  # System-wide settings
  nixpkgs.config.allowUnfree = true;

  # Window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Audio
  services.pipewire = {
     enable = true;
     wireplumber.enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };

  # System packages
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
      
  # Fonts
  fonts.packages = with pkgs; [
	noto-fonts
	adwaita-fonts
	nerd-fonts.jetbrains-mono
	noto-fonts-cjk-sans		
  ];
  
  # Nix optimization
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 7d";
  };

  # Nix settings
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05"; 
}

