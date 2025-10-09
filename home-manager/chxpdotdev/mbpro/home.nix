{
  config,
  inputs,
  pkgs,
  nhModules,
  ...
}: {
  imports = [
    "${nhModules}/common-darwin.nix"
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
