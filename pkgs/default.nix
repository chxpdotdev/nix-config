{
  pkgs ? (import ../nixpkgs.nix) {},
  inputs,
}: {
  sf-mono-liga-bin = pkgs.callPackage ./sf-mono-liga-bin.nix {
    src = inputs.sf-mono-liga-bin-src;
    version = "999-master";
  };
}
