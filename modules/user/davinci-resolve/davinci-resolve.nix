{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.davinci-resolve;
in
{
  options.modules.user.davinci-resolve = {
    enable = lib.mkEnableOption "Enable davinci-resolve";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.davinci-resolve;
    };

    enableIntelGPU = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = lib.mkIf cfg.enableIntelGPU {
      OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors";

    home.file.".local/share/DaVinciResolve/.keep".text = "";
    };
  };
}
