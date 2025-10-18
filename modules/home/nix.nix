{config, ...}: {
  home.packages = [
    config.nix.package
  ];
}
