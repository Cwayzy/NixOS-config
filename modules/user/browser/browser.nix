{ config, lib, ... }:
let
  cfg = config.modules.user.browser;
in
{
  imports = [
    ./brave/brave.nix
    ./firefox/firefox.nix
  ];

  options.modules.user.browser = {
    enable = lib.mkIf cfg.enable;
  };
}
