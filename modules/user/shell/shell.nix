{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      n = "nvim";
      sn = "sudo nvim";
      umod = "cd /home/kevin/.dotfiles/nixos/modules/user";
      smod = "cd /home/kevin/.dotfiles/nixos/modules/system";
      zen-browser = "zen-beta";
      conf = "cd $HOME/.config/hypr";
      nconf = "cd /home/kevin/.dotfiles/nixos/";
      update = "sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#C-PC";
      hupdate = "home-manager switch --flake $HOME/.dotfiles/nixos#kevin";
      upgrade = "cd $HOME/.dotfiles/nixos && nix flake update && sudo nixos-rebuild switch --flake $HOME/.dotfiles/nixos#C-PC";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';
  };
}
