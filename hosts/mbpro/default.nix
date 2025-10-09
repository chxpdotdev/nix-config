{
  inputs,
  hostname,
  darwinModules,
  ...
}: {
  imports = [
    inputs.determinate.darwinModules.default

    "${darwinModules}/common.nix"
  ];

  determinate-nix.customSettings = {
    builders-use-substitutes = true;
    # Enables parallel evaluation (remove this setting or set the value to 1 to disable)
    eval-cores = 0;

    experimental-features = [
      "build-time-fetch-tree" # Enables build-time flake inputs
      "parallel-eval" # Enables parallel evaluation
    ];

    substituters = [
      "https://nix-cache.fossi-foundation.org"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
    ];

    trusted-public-keys = [
      "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
