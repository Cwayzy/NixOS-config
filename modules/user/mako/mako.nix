{
  flake.modules.homeManager.mako = {
    services.mako = {
      enable = true;
      settings = import ./_config.nix;
    };
  };
}
