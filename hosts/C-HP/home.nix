{ config, pkgs, vars, inputs, ...}:

{
  imports =
  [
    ../../modules/user/user.nix
  ];

  modules.user = {
    shell.enable = true;
    term-apps.enable = true;
    kitty.enable = true;
    mimeapps.enable = true;
    fastfetch.enable = true;

    desktop = {
        hyprland.enable = true;
      };
      
    hypr-extras = {
      enable = true;
        hypridle.enable = true;
    };

    stylix.enable = true;
    waybar.enable = true;
    wofi.enable = true;
    mako.enable = true;

    discord ={
      enable = true;
      withVencord = true;
    };
    browser.enable = true;
    music.enable = true;
    thonny.enable = true;
  };

	home.username = vars.username;
	home.homeDirectory = "/home/${vars.username}";
	home.stateVersion = "26.05";

	home.packages = with pkgs; [];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs.home-manager.enable = true;
}
