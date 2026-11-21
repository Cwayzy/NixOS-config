{ inputs, ... }: {
  flake.modules.nixos.stylix = {
    imports = [ inputs.stylix.nixosModules.stylix ];
    home-manager.sharedModules = [ inputs.stylix.homeModules.stylix ];
  };
}
