{
	description = "NixOS Hyprland";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = {self, nixpkgs, home-manager, stylix, ...}@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      vars = {
        username = "kevin";
        hosts = [ "C-PC" "C-HP" ];
      };

      mkHost = hostName: lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs vars hostName; };
        modules = [ 
          ./hosts/${hostName}/${hostName}.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs vars hostName; };
              sharedModules = [ stylix.homeModules.stylix ];
              users.${vars.username} = import ./hosts/${hostName}/home.nix;
            };
          }
        ];
      };

    in
    { 
		  nixosConfigurations = lib.genAttrs vars.hosts mkHost;
	  };
}
