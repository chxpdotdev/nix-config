{
  inputs,
  outputs,
  config,
  lib,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
  ];

  environment = {
    shells = with pkgs; [zsh];

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        git
        nh
        vim
        ;
    };

    variables.EDITOR = "${pkgs.vim}/bin/vim";
  };

  fonts.packages = with pkgs; [sf-mono-liga-bin];

  nix.enable = false;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
    ];
  };

  programs.zsh.enable = true;

  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    home = "/Users/${userConfig.name}";
  };
}
