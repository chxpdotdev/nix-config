{
  inputs,
  outputs,
  config,
  lib,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
  ];

  environment = {
    shells = with pkgs; [zsh];

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        fd
        git
        nh
        ripgrep
        vim
        ;
    };

    variables.EDITOR = "${pkgs.vim}/bin/vim";
  };

  fonts.packages = with pkgs; [sf-mono-liga-bin];

  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    optimise.automatic = true;

    settings = {
      experimental-features = "nix-command flakes";

      substituters = [
        "https://cache.lix.systems"
        "https://cache.nixos.org"
        "https://nix-cache.fossi-foundation.org"
        "https://nix-community.cachix.org"
        "https://fortuneteller2k.cachix.org"
      ];

      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions

      (final: prev: {
        inherit
          (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };

  programs.zsh.enable = true;

  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    home = "/Users/${userConfig.name}";
  };
}
