{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.system.flatpak;
in
{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  options.modules.system.flatpak = {
    enable = lib.mkEnableOption "Enable flatpak";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of Flatpak application IDs to install";
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      remotes = [{
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }];
      packages = cfg.packages;
      update.onActivation = true;
    };
  };
}
