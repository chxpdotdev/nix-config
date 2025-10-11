{
  description = "chxpdotdev's nix config";

  outputs = {
    self,
    nixpkgs,
    home,
    ...
  } @ inputs: let
    inherit (self) outputs;

    users = {
      chxpdotdev = {
        email = "33443763+chxpdotdev@users.noreply.github.com";
        fullName = "chxp";
        name = "chxpdotdev";
      };
    };

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-darwin"
    ];

    mkDarwinConfiguration = system: hostname: username:
      inputs.nix-darwin.lib.darwinSystem {
        inherit system;

        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          darwinModules = "${self}/modules/darwin";
        };

        modules = [
          ./hosts/${hostname}
          home.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "hm-back";

              extraSpecialArgs = {
                inherit inputs outputs;
                userConfig = users.${username};
                nhModules = "${self}/modules/home-manager";
              };

              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username}.imports = [(./. + "/home-manager/${username}/${hostname}/home.nix")];
            };
          }
        ];
      };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          nixosModules = "${self}/modules/nixos";
        };

        modules = [
          ./hosts/${hostname}
          home.nixosModules.home-manager

          {
            home-manager = {
              backupFileExtension = "hm-back";

              extraSpecialArgs = {
                inherit inputs outputs;
                userConfig = users.${username};
                nhModules = "${self}/modules/home-manager";
              };

              users.${username}.imports = [(./. + "/home-manager/${username}/${hostname}/home.nix")];
            };
          }
        ];
      };
  in {
    formatter = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };

    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs inputs;}
    );

    # Devshell for bootstrapping
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      nixos-wsl = mkNixosConfiguration "nixos-wsl" "chxpdotdev";
    };

    darwinConfigurations = {
      mbpro = mkDarwinConfiguration "aarch64-darwin" "mbpro" "chxpdotdev";
    };
  };

  inputs = {
    # Nixpkgs unstable
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
    };

    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
    };

    ghostty = {
      type = "github";
      owner = "ghostty-org";
      repo = "ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      type = "github";
      owner = "nix-darwin";
      repo = "nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      type = "github";
      owner = "zhaofengli";
      repo = "nix-homebrew";
    };

    nix-index-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      type = "github";
      owner = "nix-community";
      repo = "nix-vscode-extensions";
    };

    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
    };

    nixcord = {
      type = "github";
      owner = "kaylorben";
      repo = "nixcord";
    };

    nixgl = {
      type = "github";
      owner = "nix-community";
      repo = "nixGL";
    };

    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      type = "github";
      owner = "chxpdotdev";
      repo = "nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      type = "github";
      owner = "danth";
      repo = "stylix";
    };

    vscode-server = {
      type = "github";
      owner = "nix-community";
      repo = "nixos-vscode-server";
    };

    # Other Non-flake Inputs
    homebrew-emacs-plus-src = {
      url = "github:d12frosted/homebrew-emacs-plus";
      flake = false;
    };

    sf-mono-liga-bin-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };
}
