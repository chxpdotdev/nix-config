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
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko.url = "github:nix-community/disko";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixcord.url = "github:kaylorben/nixcord";
    nixgl.url = "github:nix-community/nixGL";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:chxpdotdev/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # Non-flakes
    homebrew-cask-src.url = "github:homebrew/homebrew-cask";
    homebrew-cask-src.flake = false;

    homebrew-core-src.url = "github:homebrew/homebrew-core";
    homebrew-core-src.flake = false;

    homebrew-emacs-plus-src.url = "github:d12frosted/homebrew-emacs-plus";
    homebrew-emacs-plus-src.flake = false;

    sf-mono-liga-bin-src.url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
    sf-mono-liga-bin-src.flake = false;
  };
}
