{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.binds;
in
{
  options.modules.system.binds = {
    enable = lib.mkEnableOption "Enable system-wide keybinds";
  };

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;

      keyboards.default = {
        ids = [ "*" ];

        settings = {
          main = {
            capslock = "layer(hyper)";
            "leftshift+rightshift" = "capslock";
            pageup = "f13";
            pagedown = "f14";
          };

          "hyper:C-M-A-S" = {};
        };
      };
    };
  };
}
