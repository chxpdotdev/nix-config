{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.git
  ];

  home = {
    username = flake.config.me.serverusername;
    stateVersion = "24.11";
  };
}
