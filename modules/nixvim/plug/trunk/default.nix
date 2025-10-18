{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [neovim-trunk];
}
