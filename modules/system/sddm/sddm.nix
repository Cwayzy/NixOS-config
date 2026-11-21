{ config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.modules.nixos.sddm = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  flake.modules.nixos.sddm-autologin = { config, lib, ... }:
    let
      defaultSession =
        if config.programs.hyprland.enable then "hyprland"
        else if config.services.desktopManager.plasma6.enable then "plasma"
        else null;
    in
    {
      services.displayManager.autoLogin = {
        enable = true;
        user = username;
      };

      services.displayManager.defaultSession =
        lib.mkIf (defaultSession != null) defaultSession;
    };
}
