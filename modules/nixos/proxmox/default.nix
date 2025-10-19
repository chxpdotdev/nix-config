{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];

  services.proxmox-ve = {
    enable = true;
    bridges = ["vmbr0"];
    ipAddress = "192.168.0.1";
  };

  # Actually set up the vmbr0 bridge
  networking.bridges.vmbr0.interfaces = ["ens18"];
  networking.interfaces.vmbr0.useDHCP = pkgs.lib.mkDefault true;
}
