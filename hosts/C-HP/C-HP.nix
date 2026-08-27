{ config, lib, pkgs, vars, stylix, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/system.nix
  ];

  networking.hostName = "C-HP";

  modules.system = {
    sddm = {
      enable = true;
      autologin = true;
    };

    mount = {
      enable = true;
      home.enable = true;
      mods.enable = true;
      tesk.enable = true;
      backup.enable = true;
    };

    laptop-optimization.enable = true;
    security.enable = true;
    fingerprint.enable = true;
    audio.enable = true;

    desktop = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      plasma.enable = false;
    };

    binds.enable = true;
    bluetooth.enable = true;
    gaming.enable = true;
    flatpak.enable = true;
  };

  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "nfs" ];
	
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.settings.Sleep.HibernateDelaySec = "10min";
  boot.resumeDevice = "/dev/mapper/cryptroot";
  boot.kernelParams = [ "resume_offset=2630912" ];

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
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
	options = "--delete-older-than 7d";
  };

  programs.nix-ld.enable = true; 
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
