{ config, lib, pkgs, ...}:
let
  cfg = config.modules.user.thonny;
in 
{
  options.modules.user.thonny = {
      enable = lib.mkEnableOption "Enable thonny";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      thonny
    ];
  };
}
