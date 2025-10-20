# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{
  flake,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.darwinModules.default
  ];

  # Defined by /modules/darwin/homebrew.nix
  myHomebrew = {
    casks = [
      "chatgpt"
      "ghostty"
      "microsoft-onenote"
      "orion"
      "proton-mail-bridge"
      "steam"
      "zen"
      "zoom"
    ];

    masApps = {
      "Xcode" = 497799835;
    };

    taps = {
      "homebrew/homebrew-cask" = inputs.homebrew-cask-src;
      "homebrew/homebrew-core" = inputs.homebrew-core-src;
    };
  };

  myusers = [flake.config.me.username];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "mbpro";

  system.primaryUser = flake.config.me.username;

  # Automatically move old dotfiles out of the way
  #
  # Note that home-manager is not very smart, if this backup file already exists it
  # will complain "Existing file .. would be clobbered by backing up". To mitigate this,
  # we try to use as unique a backup file extension as possible.
  home-manager.backupFileExtension = "nix-hm-bak";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
