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
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      base16Scheme = {
        # backgrounds, darkest to lightest (taken from your wallpaper)
        base00 = "151515"; # main background (wallpaper bg)
        base01 = "1c1c1c"; # panels, status bars
        base02 = "262626"; # selection, raised surfaces (wallpaper snowflake fill)
        base03 = "3e3e3e"; # comments, borders (wallpaper outlines)

        # foregrounds
        base04 = "7a7a7a"; # dim text
        base05 = "b4b4b4"; # main text
        base06 = "c8c8c8";
        base07 = "dcdcdc";
        # accents (muted, low saturation)
        base08 = "b46a6a"; # red
        base09 = "a88563"; # orange
        base0A = "a89a6a"; # yellow
        base0B = "7f9a82"; # green
        base0C = "729a9a"; # cyan
        base0D = "8896aa"; # steel blue (primary accent)
        base0E = "9689a3"; # purple
        base0F = "857868"; # brown
      };
    targets = {
      firefox.profileNames = [ "default" ];
      hyprlock.enable = false;
      waybar.addCss = false;
      wofi.enable = false;
      rofi.enable = false;
      mako.enable = false;
      kde.enable = false;
      # qt.enable = false;
      };
      overlays.enable = false;

      cursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      };
    };
  };
}
