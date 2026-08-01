{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.openlp;
in
{
  options.modules.apps.openlp = {
    enable = lib.mkEnableOption "OpenLP via Flatpak";
  };

  config = lib.mkIf cfg.enable {
    modules.system.flatpak.packages = [
      "org.openlp.OpenLP"
    ];
  };
}
