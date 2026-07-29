{
	description = "NixOS Hyprland";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = {self, nixpkgs, home-manager, zen-browser, stylix, ...}@inputs:
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
        inherit system;
        specialArgs = { inherit inputs vars; };
        modules = [ ./hosts/${hostName}/${hostName}.nix ];
      };

    in
  { 
		nixosConfigurations = lib.genAttrs vars.hosts mkHost;

    homeConfigurations = {
      "${vars.username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit zen-browser vars; };
        modules = [ 
        stylix.homeModules.stylix
        ./home.nix
        ];
      };
    };
	};
}
