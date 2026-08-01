{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.openlp;
in
{
  options.modules.user.openlp = {
    enable = lib.mkEnableOption "Enable OpenLP";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.openlp ];
  };
}
