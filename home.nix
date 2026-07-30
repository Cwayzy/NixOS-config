{ config, pkgs, vars , zen-browser, ...}:

{
  imports = 
  [
    ./modules/user/user.nix
  ];

	home.username = vars.username;
	home.homeDirectory = "/home/${vars.username}";
	home.stateVersion = "26.05";

	# User-specific packages
	home.packages = with pkgs; [
    swaybg #temporary
	  steam
	  hyprpolkitagent
	  wl-clipboard
	  wofi
	  pwvucontrol
	  mako
	  thunar
	  blueman
    imv
    zathura
	] ++ [
	  zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
  
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
