{
  flake.modules.homeManager.hyprpaper = {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "$HOME/.dotfiles/modules/user/hypr-extras/wallpapers/nix.png" ];

        wallpaper = [
          {
            monitor  = "";
            path     = "$HOME/.dotfiles/modules/user/hypr-extras/wallpapers/nix.png";
            fit_mode = "fit";
          }
        ];
      };
    };
  };
}
