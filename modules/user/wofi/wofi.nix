{
  flake.modules.homeManager.wofi = {
    programs.wofi = {
      enable = true;
      settings = import ./_config.nix;
      style = import ./_style.nix;
    };
  };
}
