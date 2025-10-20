{
  lib,
  flake,
  config,
  ...
}: {
  imports = [
    flake.inputs.determinate.darwinModules.default

    ./common
    ./homebrew.nix
  ];

  # Determinated
  nix.enable = false;

  determinate-nix.customSettings = lib.mkMerge [
    {
      extra-substituters = config.nix.settings.extra-substituters;
      extra-trusted-substituters = config.nix.settings.extra-trusted-substituters;
      extra-trusted-public-keys = config.nix.settings.extra-trusted-public-keys;
    }

    {
      extra-experimental-features = [
        "parallel-eval"
      ];

      eval-cores = 0;
      lazy-trees = true;
    }
  ];

  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
