{ config, lib, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
  home.keyboard.layout = "gb";

  home.packages = with pkgs; [
    binutils
    #cheese
    cargo
    clang
    docker
    feh
    fira-code
    fira-code-symbols
    freerdp
    inkscape
    jq
    kitty
    libreoffice-fresh
    mosh
    ncdu
    pantheon.elementary-wallpapers
    pass
    powertop
    pstree
    qutebrowser
    ripgrep
    rustfmt
    rustc
    spotifyd
    swaybg
    swayidle
    swaylock
    thunderbird
    vlc
    #vscode-with-extensions
    xclip
    xfce.terminal
    youtube-dl
    zim


    #unstable.inkscape
    #unstable.zoom-us
    #unstable.slack
  ];

  accounts.email = {
    accounts = {
      jphim = {
        offlineimap.enable= true;
        address = "james@jph.im";
        userName = "james@jph.im";
        primary = true;
        passwordCommand = "/run/current-system/sw/bin/cat /home/james/.imappasswd";
        imap = {
          tls.enable = true;
          host = "imap.fastmail.com";
          port = 993;
        };
      };
    };
  };
  #programs.neomutt.enable= true;
  programs.offlineimap.enable= true;

  # Redshift is for changing the contrast
  services = {
    redshift = {
      enable = true;
      provider = "geoclue2";
      latitude = "50.94";
      longitude = "0.95";
    };
    screen-locker = {
      enable = false;
    };
  };
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "jiphex";
        password_cmd = "cat .config/spotify.passwd";
        device_name = "drno";
        zeroconf_port = "33999";
      };
    };
  };

  xdg.configFile = {
    "dotfiles".source = pkgs.fetchFromGitHub {
      owner = "jiphex";
      repo = "dotfiles";
      rev = "master";
      sha1 = "ky3cwmwddmv6a99cqm4ka2s6xi16wnv3";
    };
    "xfce4/terminal/terminalrc".text = ''
      [Configuration]
      MiscAlwaysShowTabs=FALSE
      MiscBell=FALSE
      MiscBellUrgent=FALSE
      MiscBordersDefault=TRUE
      MiscCursorBlinks=FALSE
      MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
      MiscDefaultGeometry=80x24
      MiscInheritGeometry=FALSE
      MiscMenubarDefault=FALSE
      MiscMouseAutohide=FALSE
      MiscMouseWheelZoom=TRUE
      MiscToolbarDefault=FALSE
      MiscConfirmClose=TRUE
      MiscCycleTabs=TRUE
      MiscTabCloseButtons=TRUE
      MiscTabCloseMiddleClick=TRUE
      MiscTabPosition=GTK_POS_TOP
      MiscHighlightUrls=TRUE
      MiscMiddleClickOpensUri=FALSE
      MiscCopyOnSelect=FALSE
      MiscShowRelaunchDialog=TRUE
      MiscRewrapOnResize=TRUE
      MiscUseShiftArrowsToScroll=FALSE
      MiscSlimTabs=FALSE
      MiscNewTabAdjacent=FALSE
      MiscSearchDialogOpacity=100
      MiscShowUnsafePasteDialog=TRUE
      FontName=Fira Code 12
      ScrollingBar=TERMINAL_SCROLLBAR_NONE
    '';
    #"i3status/config".text = ''
    #  battery 0 {
    #    last_full_capacity = true
    #    integer_battery_capacity = true
    #  }
    #'';
  };

  ## not in hm yet
  #programs.kitty = {
  #  enable = true;
  #  settings = {
  #    term = "xterm-color";
  #  };
  #};

  # Force the terminal to be xfce4
  pam.sessionVariables = {
    TERMINAL="kitty";
  };

  wayland.windowManager.sway = {
#  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
#      fonts = ["DejaVu Sans Mono 8"];
#      bars = [
#        {
#          fonts = fonts;
#        }
#      ];
#      #xssLockExtraOptions = [
#      #  "--transfer-sleep-lock"
#      #];
      floating.modifier = modifier;
#      ## Needs newer HM but fudged by the pam.sessionVariables above
#      #terminal="kitty";
      keybindings = lib.mkOptionDefault {
#        "${modifier}+i" = "focus right";
#        "${modifier}+j" = "focus left";
#        "${modifier}+k" = "focus down";
#        "${modifier}+l" = "focus up";
#        "${modifier}+Shift+i" = "move right";
#        "${modifier}+Shift+j" = "move left";
#        "${modifier}+Shift+k" = "move down";
#        "${modifier}+Shift+l" = "move up";
#        "${modifier}+Shift+semicolon" = "move right";
        "${modifier}+Shift+Return" = "exec qutebrowser";
        #"XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
        #"XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
        #"XF86AudioAudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
        #"XF86AudioAudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";
      };
      startup = [
        { command = "swaybg -i '${pkgs.pantheon.elementary-wallpapers}/share/backgrounds/Photo by SpaceX.jpg'"; always=true; }
      ];
    };
    extraConfig = ''
      # Use pactl to adjust volume in PulseAudio.
      input keyboard0 xkb_layout gb
      input keyboard1 xkb_layout gb
      set $refresh_i3status killall -SIGUSR1 i3status
    '';
  };

  systemd.user.services = {
    offlineimap = {
      Unit = {
        Description="OfflineIMAP email client";
      };
      Service = {
        ExecStart="/home/james/.nix-profile/bin/offlineimap";
        Restart="on-failure";
        RestartSec="60";
      };
      Install = {
        WantedBy=["default.target"];
      };
    };
    swayidle = {
      Unit = {
        Description = "Idle manager";
      };
      Service = {
        ExecStart = "${pkgs.swayidle}/bin/swayidle before-sleep 'swaylock -f -c 000000' timeout 300 'swaylock -f -c 000000'";
        Restart="on-failure";
        RestartSec="10";
      };
      Install = {
        WantedBy=["default.target"];
      };
    };
  };

  programs = {
    vim = {
      enable = true;
      extraConfig = ''
        set autoindent
        source ~/.config/dotfiles/vimrc.vim
      '';
    };
    vscode.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
      history = {
        extended = true;
      };
      initExtra = ''
        export EDITOR=vim
        export TERMINAL=xfce4-terminal
        bindkey -v
        bindkey '^R' history-incremental-search-backward
        source ~/.config/dotfiles/zshrc.zsh
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName  = "James Hannah";
      userEmail = "james@jph.im";
    };
  };
}
