{
  flake.modules.homeManager.bash = {
    programs.bash = {
      enable = true;
      shellAliases = {
        n = "nvim";
        sn = "sudo nvim";
        um = "cd $HOME/.dotfiles/modules/user";
        sm = "cd $HOME/.dotfiles/modules/system";
        discord = "discord -ozone-platform=x11";
        hp = "cd /$HOME/.dotfiles/modules/hosts/C-HP";
        pc = "cd /$HOME/.dotfiles/modules/hosts/C-PC";
        mac = "cd /$HOME/.dotfiles/modules/hosts/C-MAC";
        hc = "cd $HOME/.config/hypr";
        nc = "cd $HOME/.dotfiles/";
        nrs = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        upgrade = "cd $HOME/.dotfiles/ && nix flake update && sudo nixos-rebuild switch --flake $HOME/.dotfiles#$(hostname)";
        garbage = "sudo nix-collect-garbage -d";
      };
    };
  };
}
