{
  inputs,
  config,
  lib,
  userConfig,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";

    # Declarative tap management
    taps = {
      "d12frosted/homebrew-emacs-plus" = inputs.homebrew-emacs-plus-src;
    };

    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew.taps = lib.attrNames config.nix-homebrew.taps;
}
