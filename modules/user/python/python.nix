{
  flake.modules.homeManager.python = { pkgs, ... }: {
    home.packages = [ (pkgs.python3.withPackages (ps: [ ps.pygame-ce ])) ];
  };
}
