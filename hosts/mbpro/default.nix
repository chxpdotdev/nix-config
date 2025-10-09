{
  inputs,
  hostname,
  darwinModules,
  userConfig,
  ...
}: {
  imports = [
    inputs.determinate.darwinModules.default

    "${darwinModules}/common.nix"
  ];

  determinate-nix.customSettings = {
    # Enables parallel evaluation (remove this setting or set the value to 1 to disable)
    eval-cores = 0;

    extra-experimental-features = [
      "build-time-fetch-tree" # Enables build-time flake inputs
      "parallel-eval" # Enables parallel evaluation
    ];

    extra-substituters = [
      "https://cache.nixos.org?priority=12"
      "https://nix-cache.fossi-foundation.org"
      "https://nix-community.cachix.org"
      "https://fortuneteller2k.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
    ];

    trusted-users = [
      "${userConfig.name}"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
