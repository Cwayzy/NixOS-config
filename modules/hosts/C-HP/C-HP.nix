{ self, inputs, config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.nixosConfigurations.C-HP = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.C-HP ];
  };

  flake.modules.nixos.C-HP = { pkgs, ... }: {
    imports = (with self.modules.nixos; [
      base
      home-manager
      stylix

      sddm
      sddm-autologin

      mount-home
      mount-mods
      mount-tesk
      mount-backup

      usb
      laptop-optimization
      security
      fingerprint
      audio
      hyprland
      #plasma
      binds
      bluetooth
      gaming
      osu
      flatpak
    ]) ++ [ ./_hardware-configuration.nix ];

    networking.hostName = "C-HP";
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

    systemd.sleep.settings.Sleep.HibernateDelaySec = "15min";
    boot.resumeDevice = "/dev/mapper/cryptroot";
    boot.kernelParams = [ "resume_offset=2630912" ];

    time.timeZone = "Europe/Tallinn";
    i18n.defaultLocale = "en_US.UTF-8";

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
        stylix
        vesktop
        brave
        firefox
        music
        easyeffects

        hypridle   # C-HP keeps hypridle on; C-PC leaves it out

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
        thonny
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
