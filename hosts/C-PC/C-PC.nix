{ config, lib, pkgs, vars, stylix, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/system.nix
  ];

  networking.hostName = "C-PC";

  modules.system = {
    sddm = {
      enable = true;
      autologin = true;
    };

    mount = {
      enable = false;

      home = {
        enable = true;
        link.enable = true;
      };

      mods = {
        enable = true;
        link.enable = true;
      };

      tesk = {
        enable = true;
        link.enable = true;
      };

      backup = {
        enable = true;
        link.enable = false;
      };
    };

    usb.enable = true;
    laptop-optimization.enable = false;
    security.enable = false;
    fingerprint.enable = false;
    audio.enable = true;

    desktop = {
      hyprland = {
        enable = true;
        withUWSM = false;
      };
      plasma.enable = false;
    };

    binds.enable = true;
    bluetooth.enable = false;
    gaming.enable = false;
    flatpak.enable = false;
  };

  networking.networkmanager.enable = true;
  services.tailscale.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "nfs" ];
	
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone =  "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "et";
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    uid = 1026;
    extraGroups = [ "wheel" "networkmanager" "video" "render" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    killall
    alsa-plugins
    bluez
    libnotify
    font-awesome
    wget
    wev
    gcc
    networkmanagerapplet
  ];

  fonts.packages = with pkgs; [
	noto-fonts
	adwaita-fonts
	nerd-fonts.jetbrains-mono
	noto-fonts-cjk-sans
  ];

  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 3d";
  };

  programs.nix-ld.enable = true; 
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
