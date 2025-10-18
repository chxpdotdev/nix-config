{
  lib,
  pkgs,
  ...
}: {
  home.shell.enableShellIntegration = true;

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        # Custom bash profile goes here
      '';
    };

    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      initContent = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

        set -k
        setopt auto_cd
        setopt NO_NOMATCH   # disable some globbing

        precmd() {
          printf '\033]0;%s\007' "$(dirs)"
        }

        command_not_found_handler() {
          printf 'Command not found ->\033[32;05;16m %s\033[0m \n' "$0" >&2
          return 127
        }

        export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
      '';

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        save = 50000;
      };

      shellAliases = {
        cat = "${lib.getExe pkgs.bat} --color always --plain";
        grep = "grep --color=auto";
        c = "clear";
      };
    };

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;

    # Better shell prompt
    starship = {
      enable = true;

      settings = {
        character = {
          error_symbol = "[>>](bold red)";
          success_symbol = "[>>](bold green)";
          vicmd_symbol = "[>>](bold yellow)";
          format = "$symbol ";
        };

        format = "$all";
        add_newline = false;

        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };

        line_break.disabled = false;
        directory.disabled = false;
        nodejs.disabled = true;
        nix_shell.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
        rust.symbol = "[](red) ";
        lua.symbol = "[](blue) ";
        package.symbol = "📦  ";
      };
    };
  };
}
