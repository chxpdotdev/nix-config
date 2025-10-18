{
  flake,
  config,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.vscode-server.nixosModules.default

    self.nixosModules.default

    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  myusers = ["admin"];

  networking = {
    firewall.allowedTCPPorts = [22];
    hostName = "volta";
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    openssh = {
      ports = [22];

      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
        X11Forwarding = true;
      };
    };

    tailscale.enable = true;
    vscode-server.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  time.timeZone = "America/Los_Angeles";
}
