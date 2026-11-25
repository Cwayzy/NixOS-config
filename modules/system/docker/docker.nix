{ config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    users.users.${username}.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
