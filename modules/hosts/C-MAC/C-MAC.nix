{ self, inputs, config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.nixosConfigurations.C-MAC = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.C-MAC ];
  };

  flake.modules.nixos.C-MAC = { pkgs, config, lib, ... }: {
    imports = (with self.modules.nixos; [
      base
      home-manager

      sddm

      mount-home
      mount-mods
      mount-tesk
      mount-backup

      usb
      laptop-optimization
      security
      audio
      binds
      plasma
      bluetooth
      gaming
      osu
      flatpak
    ]) ++ [ ./_hardware-configuration.nix ];

    networking.hostName = "C-MAC";
    networking.networkmanager.enable = true;
	    services.tailscale.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.supportedFilesystems = [ "nfs" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    
    boot.initrd.kernelModules = [ "wl" ];
    boot.kernelModules = [ "wl" ];
    boot.blacklistedKernelModules = [
      "b43"
      "bcma"
      "ssb"
      "brcmfmac"
      "brcmsmac"
    ];
    
    nixpkgs.config.allowInsecurePredicate = pkg:
      lib.getName pkg == "broadcom-sta";

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend-then-hibernate";
      HandleLidSwitchDocked = "ignore";
    };

    time.timeZone = "Europe/Tallinn";
    i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
	  LC_TIME        = "et_EE.UTF-8";
	  LC_NUMERIC     = "et_EE.UTF-8";
	  LC_MONETARY    = "et_EE.UTF-8";
	  LC_PAPER       = "et_EE.UTF-8";
	  LC_MEASUREMENT = "et_EE.UTF-8";
	  LC_COLLATE     = "et_EE.UTF-8";
	  LC_ADDRESS     = "et_EE.UTF-8";
	  LC_TELEPHONE   = "et_EE.UTF-8";
	  LC_NAME        = "et_EE.UTF-8";
	};

    console = {
      font = "Lat2-Terminus16";
      keyMap = "et";
    };

    users.users.${username} = {
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
      options = "--delete-older-than 3d";
    };

    programs.nix-ld.enable = true;
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "26.05";

    home-manager.users.${username} = { lib, pkgs, ... }: {
      imports = with self.modules.homeManager; [
        bash
        term-apps
        kitty
	mimeapps
        fastfetch
        vesktop
        brave
        firefox
        music
        easyeffects

        mount-home-link
        mount-mods-link
        mount-tesk-link
      ];

      services.easyeffects.preset = "fifine-mic";

      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "26.05";

      home.packages = with pkgs; [
        ytdownloader
        filezilla
        bootstrap-studio
      ];

      xdg.userDirs.enable = false;

      home.sessionVariables = {
        EDITOR = "nvim";
        QT_QPA_PLATFORMTHEME = lib.mkForce null;
      };

      programs.home-manager.enable = true;
    };
  };
}
