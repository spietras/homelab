{
  config,
  pkgs,
  ...
}: let
  jsonFormat = pkgs.formats.json {};
in {
  home = {
    packages = [
      pkgs.bandwhich
      pkgs.beep
      pkgs.chafa
      pkgs.chatgpt-cli
      pkgs.cpufetch
      pkgs.croc
      pkgs.ctop
      pkgs.curlie
      pkgs.dasel
      pkgs.duf
      pkgs.exa
      pkgs.fastfetch
      pkgs.fd
      pkgs.ffmpeg
      pkgs.gdu
      pkgs.graphicsmagick
      pkgs.hyperfine
      pkgs.jqp
      pkgs.krabby
      pkgs.lazydocker
      pkgs.lolcat
      pkgs.miller
      pkgs.neo
      pkgs.neo-cowsay
      pkgs.nms
      pkgs.nodePackages.serve
      pkgs.pastel
      pkgs.portal
      pkgs.sl
      pkgs.speedtest-go
      pkgs.systeroid
      # Disable installing completions for trashy
      (pkgs.trashy.overrideAttrs (f: p: {preFixup = "";}))
      pkgs.ttyd
      pkgs.up
      pkgs.upterm
      pkgs.usql
      pkgs.vhs
      pkgs.xh
      pkgs.zfxtop
    ];

    shellAliases = {
      ex = "exa --icons";
      zj = "systemd-run --user --scope --quiet -- zellij";
    };
  };

  programs = {
    bat = {
      config = {
        theme = "Visual Studio Dark+";
      };

      enable = true;

      extraPackages = [
        pkgs.bat-extras.batdiff
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batman
        pkgs.bat-extras.batpipe
        pkgs.bat-extras.batwatch
      ];
    };

    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    btop = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv = {
        enable = true;
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    jq = {
      enable = true;
    };

    man = {
      enable = true;
      generateCaches = true;
    };

    mcfly = {
      enable = true;
      enableZshIntegration = true;
    };

    nnn = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    tealdeer = {
      enable = true;

      settings = {
        updates = {
          auto_update = true;
        };
      };
    };

    translate-shell = {
      enable = true;
    };

    yt-dlp = {
      enable = true;
    };

    zellij = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      initExtraBeforeCompInit = ''
        # Completions for trashy are broken, so we ignore them
        zstyle ':completion:*:*:trash:*' completer _ignored
      '';

      shellAliases = {
        cgpt = "OPENAI_API_KEY=\"$(cat ${config.sops.secrets."openai/apiKey".path})\" chatgpt";
      };
    };
  };

  services = {
    pueue = {
      enable = true;

      settings = {
        shared = {};
        client = {};
        daemon = {};
      };
    };
  };

  xdg = {
    configFile = {
      "chatgpt/config.json" = {
        source = jsonFormat.generate "chatgpt-config" {
          prompts = {
            code = "Answer only with code.";
            cmd = "Answer only with commands.";
            default = "Answer as concisely as possible.";
            emoji = "Answer only with my query translated to emojis.";
            translate = "Answer only with the translation.";
          };
        };
      };
    };
  };
}
