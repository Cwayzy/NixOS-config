{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = import ./config.nix;
  };
}
