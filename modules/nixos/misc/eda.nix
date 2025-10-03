{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.nix-eda.overlays.default
  ];

  environment = {
    systemPackages = with pkgs; [magic netgen ngspice klayout xschem gtkwave xterm gaw] ++ [inputs.ciel.packages.${pkgs.system}.ciel];
  };
}
