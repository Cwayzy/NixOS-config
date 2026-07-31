{ config, lib, ... }:
let
  cfg = config.modules.user.shell;
in 
{
  options.modules.user.shell = {
    enable = lib.mkEnableOption "Enable shell";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        n = "nvim";
        sn = "sudo nvim";
        um = "cd $HOME/.dotfiles/modules/user";
        sm = "cd $HOME/.dotfiles/modules/system";
        zen-browser = "zen-beta";
        hc = "cd $HOME/.config/hypr";
        nc = "cd $HOME/.dotfiles/";
        nrs = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        hms = "home-manager switch --flake $HOME/.dotfiles#$(whoami)";
        upgrade = "cd $HOME/.dotfiles/ && nix flake update && sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
      };
    };
  };
}
