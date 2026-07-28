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

	outputs = {nixpkgs, home-manager, zen-browser, stylix, ...}:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
    in
  { 
		nixosConfigurations.C-PC = lib.nixosSystem {
			inherit system;
			modules = [
      ./configuration.nix
      ];
		};

    homeConfigurations = {
      kevin = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit zen-browser; };
        modules = [ 
        stylix.homeModules.stylix
        ./home.nix
        ];
        };
      };
	};
}
