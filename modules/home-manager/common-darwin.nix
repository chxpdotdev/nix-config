{
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/git.nix
    ./programs/nixvim.nix
    ./programs/starship.nix
    ./programs/zsh.nix
  ];

  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        alejandra
        deadnix
        nh
        nixd
        statix
        ;

      inherit
        (pkgs.luajitPackages)
        jsregexp
        ;

      inherit
        (pkgs.nodePackages_latest)
        prettier
        prettier_d_slim
        ;
    };

    shell.enableShellIntegration = true;
  };
}
