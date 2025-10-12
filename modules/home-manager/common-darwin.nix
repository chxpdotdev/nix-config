{
  inputs,
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
    ./programs/nixcord.nix
    ./programs/nixvim.nix
    ./programs/starship.nix
    ./programs/vscode.nix
    ./programs/zsh.nix

    inputs.mac-app-util.homeManagerModules.default
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
    };

    shell.enableShellIntegration = true;
  };
}
