{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = import ./config.nix;
    style = import ./style.nix;
  };
}
