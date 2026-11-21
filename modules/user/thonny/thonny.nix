{
  flake.modules.homeManager.thonny = { pkgs, ...}: {
    home.packages = [ pkgs.thonny ];
  };
}
