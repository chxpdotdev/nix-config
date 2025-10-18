{flake, ...}: {
  imports = [
    # An existing Linux builder is needed to initially bootstrap `nix-rosetta-builder`.
    # If one isn't already available: comment out the `nix-rosetta-builder` module below,
    # uncomment this `linux-builder` module, and run `darwin-rebuild switch`:
    # {nix.linux-builder.enable = true;}
    # Then: uncomment `nix-rosetta-builder`, remove `linux-builder`, and `darwin-rebuild switch`
    # a second time. Subsequently, `nix-rosetta-builder` can rebuild itself.
    flake.inputs.nix-rosetta-builder.darwinModules.default

    ./common
    ./homebrew.nix
  ];

  nix-rosetta-builder.onDemand = true;

  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
