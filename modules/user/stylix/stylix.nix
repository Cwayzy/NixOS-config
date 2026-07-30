{ config, lib, pkgs, ...}:
let
  cfg = config.modules.user.stylix;
in 
{
  options.modules.user.stylix = {
    enable = lib.mkEnableOption "Enable stylix";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
        image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Cwayzy/cwayzy-dotfiles/f6a2b11df29a3d320a7f037d6453674d0824c642/.config/hypr/wallpaper/dreamy.png";
          hash = "sha256-suN8kjWn/GCkFu6vkrXVpazc5nMl/542HArVcGr6R0I=";
        };
      targets = {
        hyprlock.enable = false;
        waybar.enable = false;
        wofi.enable = false;
        mako.enable = false;
      };
    };
  };
}
