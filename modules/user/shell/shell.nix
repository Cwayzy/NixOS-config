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
        umod = "cd /home/kevin/.dotfiles/modules/user";
        smod = "cd /home/kevin/.dotfiles/modules/system";
        zen-browser = "zen-beta";
        conf = "cd $HOME/.config/hypr";
        nconf = "cd /home/kevin/.dotfiles/";
        update = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        hupdate = "home-manager switch --flake $HOME/.dotfiles#$(whoami)@$(hostname)";
        upgrade = "cd $HOME/.dotfiles/ && nix flake update && sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
      };
      profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec start-hyprland
        fi
      '';
    };
  };
}
