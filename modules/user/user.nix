{ ... }:
{
  imports = [
    ./shell/shell.nix
    ./shell/term-apps.nix
    ./kitty/kitty.nix
    ./mimeapps/mimeapps.nix
    ./fastfetch/fastfetch.nix
    ./hyprland/hyprland.nix
    ./hypr-extras/hypr-extras.nix
    ./stylix/stylix.nix
    ./waybar/waybar.nix
    ./wofi/wofi.nix
    ./mako/mako.nix
    ./discord/discord.nix
    ./zen/zen.nix
  ];

  modules.user = {
    shell.enable = true;
    term-apps.enable = true;
    kitty.enable = true;
    mimeapps.enable = true;
    fastfetch.enable = true;
    hyprland.enable = true;
    hypr-extras = {
      enable = true;
        hypridle.enable = false;
    };
    stylix.enable = true;
    waybar.enable = true;
    wofi.enable = true;
    mako.enable = true;
    discord.enable = true;
    zen.enable = true;
  };
}
