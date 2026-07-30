{ config, pkgs, vars, inputs, ...}:

{
  imports = 
  [
    ./modules/user/user.nix
  ];

	home.username = vars.username;
	home.homeDirectory = "/home/${vars.username}";
	home.stateVersion = "26.05";

	# User-specific packages
	home.packages = with pkgs; [];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
