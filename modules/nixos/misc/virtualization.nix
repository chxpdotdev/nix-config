{pkgs, ...}: {
  environment.systemPackages = [pkgs.distrobox];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
