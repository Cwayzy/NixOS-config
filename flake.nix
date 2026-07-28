{
	description = "NixOS Hyprland";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

	outputs = {nixpkgs, disko ,home-manager, zen-browser, stylix, ...}:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
    in
  { 
		nixosConfigurations."C-PC" = lib.nixosSystem {
			inherit system;
			modules = [
        disko.nixosModules.disko
        ./disk-config.nix
        ./configuration.nix

        ({ pkgs, ... }: {
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          networking.hostName = "C-PC";
          networking.networkmanager.enable = true;

          users.users.kevin = {
            isNormalUser = true;
            extraGroups = [ "wheel" "networkmanager" ];
          };

          system.stateVersion = "24.11";
        })
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
