{
  flake,
  config,
  lib,
  ...
}: {
  imports = [
    flake.inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  options = with lib; {
    myHomebrew = {
      casks = mkOption {
        type = types.listOf types.str;
        description = "List of casks to install";
      };

      masApps = mkOption {
        type = types.attrs;
        description = "Set of Mac apps and IDs to use";
      };

      taps = mkOption {
        type = types.attrs;
        description = "Set of taps to use";
      };
    };
  };

  config = {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = flake.config.me.username;

      # Declarative tap management
      taps = config.myHomebrew.taps;

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
      casks = config.myHomebrew.casks;
      masApps = config.myHomebrew.masApps;
      taps = lib.attrNames config.nix-homebrew.taps;
    };
  };
}
