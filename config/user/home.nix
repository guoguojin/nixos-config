{ config, pkgs, nixpkgs, ... }:

let
  user = "tanq";
in {
  home.file = {
    "${config.xdg.configHome}/zsh/.p10k.zsh" = {
      source = ../../dotfiles/zsh/p10k.zsh;
    };

    "${config.xdg.configHome}/zsh/java_version.zsh" = {
      source = ../../dotfiles/zsh/java_version.zsh;
    };

    "${config.xdg.configHome}/zsh/task.zsh" = {
      source = ../../dotfiles/zsh/task.zsh;
    };

    "${config.xdg.configHome}/i3/config" = {
      source = ../../dotfiles/i3/config;
    };

    "${config.xdg.configHome}/polybar" = {
      source = ../../dotfiles/polybar;
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
}