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
        discord = "discord -ozone-platform=x11";
        hp = "cd /$HOME/.dotfiles/hosts/C-HP";
        pc = "cd /$HOME/.dotfiles/hosts/C-PC";
        hc = "cd $HOME/.config/hypr";
        nc = "cd $HOME/.dotfiles/";
        nrs = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        upgrade = "cd $HOME/.dotfiles/ && nix flake update && sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        garbage = "sudo nix-collect-garbage -d";
      };
    };
  };
}
