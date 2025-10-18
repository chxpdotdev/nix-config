{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.git
  ];

  home = {
    username = flake.config.volta.username;
    stateVersion = "24.11";
  };
}
