{
  flake,
  pkgs,
  ...
}: {
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    omnix

    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    gnumake

    # Nix dev
    alejandra
    cachix
    deadnix
    nh
    nixd # Nix language server
    nix-info
    nixpkgs-fmt
    statix

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    # Nixvim Config
    (flake.inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
      inherit pkgs;
      module = import ../nixvim;
    })
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs.jq.enable = true;
}
