{
  pkgs,
  inputs,
  hostname,
  darwinModules,
  userConfig,
  ...
}: {
  imports = [
    "${darwinModules}/common.nix"
    "${darwinModules}/homebrew.nix"
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
