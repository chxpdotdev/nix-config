{
  inputs,
  config,
  lib,
  userConfig,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";

    # Declarative tap management
    taps = {
      "homebrew/homebrew-cask" = inputs.homebrew-cask-src;
      "homebrew/homebrew-core" = inputs.homebrew-core-src;
    };

    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };

  homebrew = {
    # This is a module from nix-darwin
    # Homebrew is *installed* via the flake input nix-homebrew

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #

    enable = true;

    casks = [
      "chatgpt"
      "ghostty"
      "microsoft-onenote"
      "proton-mail-bridge"
      "steam"
      "zen"
      "zoom"
    ];

    masApps = {
      "Xcode" = 497799835;
    };

    taps = lib.attrNames config.nix-homebrew.taps;
  };
}
