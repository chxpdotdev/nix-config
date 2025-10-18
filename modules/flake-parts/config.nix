# Top-level configuration for everything in this repo.
#
# Values are set in 'config.nix' in repo root.
{lib, ...}: let
  userSubmodule = lib.types.submodule {
    options = {
      serverusername = lib.mkOption {
        type = lib.types.str;
      };
      username = lib.mkOption {
        type = lib.types.str;
      };
      fullname = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
in {
  imports = [
    ../../config.nix
  ];
  options = {
    me = lib.mkOption {
      type = userSubmodule;
    };
  };
}
