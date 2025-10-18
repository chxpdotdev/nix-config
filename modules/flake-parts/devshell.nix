{inputs, ...}: {
  imports = [
    (inputs.git-hooks + /flake-module.nix)
  ];

  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "chxp-nix-config-shell";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        nh
        nixd
      ];
    };

    pre-commit.settings = {
      hooks.alejandra.enable = true;
    };
  };
}
