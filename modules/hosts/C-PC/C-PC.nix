{ self, inputs, config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.nixosConfigurations.C-PC = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.modules.nixos.C-PC ];
  };

  flake.modules.nixos.C-PC = { pkgs, ... }: {
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
      security
      audio
      hyprland
      #plasma
      binds
      bluetooth
      gaming
      sim-racing
      osu
      flatpak
    ]) ++ [ ./_hardware-configuration.nix ];

    networking.hostName = "C-PC";
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.supportedFilesystems = [ "nfs" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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

    # ---- home-manager (was hosts/C-PC/home.nix) ----
    home-manager.users.${username} = { lib, pkgs, ... }: {
      imports = with self.modules.homeManager; [
        shell
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
