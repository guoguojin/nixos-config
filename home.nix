{ config, pkgs, nixpkgs, ... }:

let
  user = "tanq";
in {
  home.file = {
    "${config.xdg.configHome}/zsh/.p10k.zsh" = {
      source = ./dotfiles/zsh/p10k.zsh;
    };

    "${config.xdg.configHome}/zsh/java_version.zsh" = {
      source = ./dotfiles/zsh/java_version.zsh;
    };

    "${config.xdg.configHome}/zsh/task.zsh" = {
      source = ./dotfiles/zsh/task.zsh;
    };
  };
  
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";

    packages = with pkgs; [
      rustup
      google-chrome
      brave
      lastpass-cli
      tomb
      dropbox
      niv
    ];

  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      initExtra = ''
      # Source powerlevel10k
      source ${config.xdg.configHome}/zsh/.p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';

      shellAliases = {
        ll = "ls -l";
      };

      history = {
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        size = 10000;
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
    };
  };
}

