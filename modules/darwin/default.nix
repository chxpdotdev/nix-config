# This is your nix-darwin configuration.
# For home configuration, see /modules/home/*
{
  imports = [
    ./common
    ./homebrew.nix
  ];

  # Use TouchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
