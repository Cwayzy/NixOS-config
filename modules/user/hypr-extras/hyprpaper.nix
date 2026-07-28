{ pkgs, ... }:
{
  home.packages = with pkgs; [hyprpaper];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "$HOME/.config/hypr/wallpapers/dreamy.png" ];

      wallpaper = [
        {
          monitor  = "";
          path     = "$HOME/.config/hypr/wallpapers/dreamy.png";
          fit_mode = "fit";
        }
      ];
    };
  };
}
