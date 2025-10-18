{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.default
  ];

  home = {
    username = flake.config.me.username;
    stateVersion = "24.11";
  };
}
