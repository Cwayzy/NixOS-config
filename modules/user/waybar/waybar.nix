{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings.mainBar= (import ./config.nix).mainBar // (import ./modules.nix);
    style = import ./style.nix;
  };
}
