{
  flake.modules.homeManager.fastfetch = {
    programs.fastfetch = {
      enable = true;
      settings = import ./_config.nix;
    };
  };
}
