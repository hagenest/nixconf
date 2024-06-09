{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hagi";
  home.homeDirectory = "/home/hagi";

  # Packages that should be installed to the user profile.
  home.packages = [
    # cli programs
    pkgs.lunarvim
    pkgs.nerdfonts
    pkgs.btop
    pkgs.distrobox
    pkgs.podman
    pkgs.python311Packages.osc
    pkgs.pass-wayland
    pkgs.helix
    pkgs.helix-gpt
    pkgs.neofetch
    pkgs.nerdfetch
    pkgs.rclone
    pkgs.openssl
    pkgs.nixfmt
    pkgs.zerotierone # p2p vpn thingy for work
    pkgs.ripgrep
    pkgs.nix-tree
    pkgs.hugo
    pkgs.android-tools
    pkgs.wget
    pkgs.quickemu # spin up vms fast @wimpy
    pkgs.lazygit

    # gpg related stuff
    pkgs.sequoia-sq
    pkgs.sequoia-chameleon-gnupg # can't use this via cli, not sure why
    pkgs.gnupg # so Werner Koch was right all along, I guess

    # language toolchains
    pkgs.devenv # declare devenv in nix
    pkgs.rustup
    pkgs.poetry # TODO find out how to use poetry2nix
    pkgs.gcc # needed for cargo
    pkgs.nodejs_18 # you gotta do, what you gotta do

    # development stuff
    pkgs.debian-devscripts

    # python packages
    pkgs.python3
    pkgs.python311Packages.pip
    pkgs.pyinfra
    pkgs.python311Packages.matplotlib
    pkgs.python311Packages.pandas

    # random dependencies
    pkgs.stdenv.cc.cc.lib # this is needed for some pip-packages, doesn't work tho
    pkgs.gtop # for tophat gnome extension

    # 3d printer
    pkgs.prusa-slicer
    pkgs.printrun
    pkgs.cura # proprietary slicer

    # awesome nix stuff
    pkgs.colmena # actually nixos-rebuild does everything I need, but I'll keep this anyways

    # desktop apps

    # messenger
    pkgs.element-desktop
    pkgs.deltachat-desktop
    pkgs.signal-desktop
    pkgs.kdeltachat
    pkgs.neochat
    pkgs.fractal

    # office-related stuff
    pkgs.libreoffice
    pkgs.obsidian
    pkgs.logseq
    pkgs.thunderbird
    pkgs.rnote # foss pen note taking app
    pkgs.foliate # e-reader

    # misc
    pkgs.protonvpn-gui
    pkgs.blackbox-terminal
    pkgs.freetube
    pkgs.easyeffects
    pkgs.popcorntime
    pkgs.rclone-browser
    pkgs.metasploit
    pkgs.kdePackages.kleopatra
    pkgs.tor-browser
    pkgs.chromium
    pkgs.gitkraken # I'm not proud to sometimes need this
    pkgs.gnome.gnome-tweaks
    pkgs.spotube

    # games
    pkgs.openttd

    # wine
    pkgs.bottles

    # testing some cosmic apps
    pkgs.cosmic-term
    pkgs.cosmic-files
    pkgs.cosmic-design-demo
    # wow, they really aren't all that great yet

    # Gnome Extensions
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.tophat
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.teatimer
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.media-controls
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    delta.enable = true; # enable delta syntax highlighter
    ignores = [ ".vscode" ".DS_STORE" ".idea" ];
    userEmail = "mail@hagenest.dev";
    userName = "Christian Hagenest";
    extraConfig = {
      pull = { rebase = true; };
      rebase = { autoStash = true; };
      push = { autoSetupRemote = true; };
      init = { defaultBranch = "main"; };
    };
  };

  # Dconf settings
  dconf = {
    enable = true;
    # dark mode default
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.ms-python.vscode-pylance
      pkgs.vscode-extensions.ms-toolsai.jupyter
      pkgs.vscode-extensions.ms-python.isort
      pkgs.vscode-extensions.rust-lang.rust-analyzer
      pkgs.vscode-extensions.github.copilot
      pkgs.vscode-extensions.github.copilot-chat
      pkgs.vscode-extensions.bbenoist.nix
    ];
    mutableExtensionsDir =
      false; # forbid installation of extensions without nix
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [
      "git"
      "sudo"
      "command-not-found"
      "colorize"
      "git-auto-fetch"
      "podman"
      "man" # use esc + man to see the man page of the previous command
      "python"
      "ripgrep"
      "vscode"
    ];
    oh-my-zsh.theme = "re5et";
  };

  programs.nushell = { enable = true; };

  programs.firefox = {
    enable = true;
    profiles.default = { bookmarks = { }; };
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
    settings.updates.auto_update_interval_hours = 12;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  services.ssh-agent.enable = true;
}
