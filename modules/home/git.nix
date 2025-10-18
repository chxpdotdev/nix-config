{flake, ...}: {
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  programs = {
    git = {
      enable = true;
      userName = flake.config.me.fullname;
      userEmail = flake.config.me.email;
      ignores = ["*~" "*.swp"];

      extraConfig = {
        init.defaultBranch = "main";
        core.editor = {};
      };
    };

    lazygit.enable = true;
  };
}
