{ config, lib, ... }:
let
  cfg = config.modules.user.hypr-extras;
in 
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprshot.nix
    ./hyprpolkitagent.nix
    ./hyprpicker.nix
    ./hyprpaper.nix
    ./files.nix
  ];

  options.modules.user.hypr-extras = {
    enable = lib.mkEnableOption "Enable hypr-extras";
  };
}
