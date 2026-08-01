{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.openlp;
in
{
  options.modules.system.openlp = {
    enable = lib.mkEnableOption "OpenLP via Flatpak";
  };

  config = lib.mkIf cfg.enable {
    modules.system.flatpak.packages = [
      "org.openlp.OpenLP"
    ];
  };
}
