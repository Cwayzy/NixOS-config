{ config, lib, pkgs, vars, inputs, ...}:

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
    stylix.enable = true;
    discord ={
      enable = true;
      withVencord = true;
    };
    browser.enable = true;
    music.enable = true;
    thonny.enable = true;
    davinci-resolve = {
      enable = true;
      enableIntelGPU = true;
    };
  };

	home.username = vars.username;
	home.homeDirectory = "/home/${vars.username}";
	home.stateVersion = "26.05";

	home.packages = with pkgs; [];

  xdg.userDirs.enable = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = lib.mkForce null;
  };
  
  programs.home-manager.enable = true;
}
