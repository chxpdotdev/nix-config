# Top-level flake glue to get our configuration working
{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    formatter = pkgs.alejandra;

    # Flake inputs we want to update periodically
    # Run: `nix run .#update`.
    nixos-unified = {
      primary-inputs = [
        "nixpkgs"
        "home-manager"
        "nix-darwin"
        "nix-index-database"
        "nixvim"
      ];
    };

    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
  };
}
