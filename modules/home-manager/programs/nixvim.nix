{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    extraPlugins = lib.attrValues {
      inherit
        (pkgs.vimPlugins)
        mini-nvim
        ;
    };

    opts = {
      number = true;
    };
  };
}
