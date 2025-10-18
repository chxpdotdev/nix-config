{
  flake,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs;

  marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    koihik.vscode-lua-format
    rvest.vs-code-prettier-eslint
    sndst00m.markdown-github-dark-pack
  ];
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
          esbenp.prettier-vscode
          github.github-vscode-theme
          github.codespaces
          github.copilot-chat
          jnoortheen.nix-ide
          kamadorueda.alejandra
          mshr-h.veriloghdl
          ms-vscode.cpptools
          ms-vscode-remote.vscode-remote-extensionpack
          mkhl.direnv
          sumneko.lua
          xaver.clang-format
        ]
        ++ marketplace-extensions;

      userSettings = with config.stylix.fonts; {
        Lua.misc.executablePath = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";

        "[c]".editor.defaultFormatter = "xaver.clang-format";
        "[cpp]".editor.defaultFormatter = "xaver.clang-format";
        "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
        "[lua]".editor.defaultFormatter = "Koihik.vscode-lua-format";
        "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
        "[python]".editor.formatOnType = true;

        breadcrumbs.enabled = false;

        editor = {
          cursorBlinking = "smooth";
          fontFamily = "'Liga SFMono Nerd Font', Monaco, 'Courier New', monospace";
          fontLigatures = true;
          formatOnSave = true;
          lineNumbers = "on";
          minimap.enabled = false;
          smoothScrolling = true;
          stickyScroll.enabled = false;

          bracketPairColorization = {
            enabled = true;
            independentColorPoolPerBracketType = true;
          };
        };

        nix.serverPath = "${lib.getExe pkgs.nixd}";

        terminal.integrated = {
          cursorBlinking = true;
          cursorStyle = "line";
          fontLigatures.enabled = true;
          smoothScrolling = true;
          stickyScroll.enabled = false;
        };

        # window = {
        #   menuBarVisibility = "toggle";
        #   nativeTabs = true;
        #   titleBarStyle = "custom";
        # };

        workbench = {
          colorTheme = lib.mkForce "GitHub Dark Default";
          list.smoothScrolling = true;
          smoothScrolling = true;
        };
      };
    };
  };
}
