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
    pkgs.python311Packages.osc
    pkgs.pass-wayland
    pkgs.helix
    pkgs.helix-gpt

    # desktop apps
    
    # messenger
    pkgs.element-desktop
    pkgs.deltachat-desktop
    pkgs.signal-desktop

    # misc
    
    pkgs.protonvpn-gui
    pkgs.blackbox-terminal
    pkgs.freetube
    pkgs.logseq
    pkgs.easyeffects

    # testing some cosmic apps
    pkgs.cosmic-term
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
    userEmail = "mail@hagenet.dev";
    userName = "Christian Hagenest";
  };

  programs.gitui.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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

  programs.firefox = {
    enable = true;
    profiles.default = {
      bookmarks = { };
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  services.ssh-agent.enable = true;
}
