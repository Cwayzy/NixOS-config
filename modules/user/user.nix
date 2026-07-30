{ ... }:
{
  imports = [
    ./shell/shell.nix
    ./shell/term-apps.nix
    ./kitty/kitty.nix
    ./waybar/waybar.nix
    ./hyprland/hyprland.nix
    ./hypr-extras/hypr-extras.nix
    ./stylix/stylix.nix
    ./mimeapps/mimeapps.nix
    ./wofi/wofi.nix
    ./fastfetch/fastfetch.nix
    ./mako/mako.nix
    ./discord/discord.nix
  ];

  modules.user = {
    discord = {
      enable = true;
      package = "discord";

      betterdiscord = {
        enable = true;
        pluginsDir = ./discord/plugins;
        themesDir = ./discord/themes;
      };
    };
  };
}
