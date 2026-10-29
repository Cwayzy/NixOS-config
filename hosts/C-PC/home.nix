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
      package = "vesktop";
      # withVencord = true;
    };
    browser.enable = true;
    music.enable = true;
    thonny.enable = false;
    davinci-resolve = {
      enable = false;
      enableIntelGPU = false;
    };
    easyeffects = {
      enable = true;
      preset = "fifine_mic";
    };
  };

	home.username = vars.username;
	home.homeDirectory = "/home/${vars.username}";
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
    ytdownloader
    filezilla
    bootstrap-studio
  ];

  xdg.userDirs.enable = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = lib.mkForce null;
  };
  
  programs.home-manager.enable = true;
}
