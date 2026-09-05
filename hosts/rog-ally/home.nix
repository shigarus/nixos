{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.pi.homeModules.default
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # Allow unfree packages for this Home Manager configuration. This works both
  # when imported from NixOS and when used as a standalone Home Manager config.
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shigarus";
  home.homeDirectory = "/home/shigarus";

  # kde plasma configuration
  programs.plasma = {
    enable = true;
    input.keyboard = {
      numlockOnStartup = "on";
      layouts = [ { layout = "us"; } { layout = "ru"; } ];
    };
    # Does not work my way, always opens new application instead of switching.
    # Plasma has only way of pinnig apps to specific
    # doc positions and switching to them via Meta+Num.
    # While macos uses the sam shortcut to switch tabs withit one application.
    # hotkeys.commands."to-ghostty" = {
    #   name = "Ghostty";
    #   key = "Ctrl+Shift+Alt+k";
    #   command = "ghostty";
    # };
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    bat
    btop
    cargo
    dig
    docker
    docker-compose
    fd
    fish-lsp
    fzf
    emacs
    eza
    gcc
    gimp
    git
    git-credential-manager
    git-lfs
    grpcurl
    ghostty
    jfrog-cli
    jq
    jwt-cli
    keymapp # zsa oryx
    kubectl
    kubie
    k9s
    maven
    neovim
    # npm
    parallel
    ripgrep
    # teamcity-cli not in nexpkgs
    shellcheck
    shfmt
    tailscale
    terraform
    tilt
    tldr
    tree-sitter
    tmux
    starship
    stow
    unzip
    vhs
    yazi
    yq
    zoxide
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shigarus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.pi.coding-agent = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
