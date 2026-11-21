{ self, config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.modules.nixos.hyprland = { lib, ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = lib.mkDefault true;
    };

    home-manager.users.${username}.imports = with self.modules.homeManager; [
      hyprland
      waybar
      wofi
      mako
      hyprlock
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprshot
      hypr-files
    ];
  };
}
