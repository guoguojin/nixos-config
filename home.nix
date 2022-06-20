{ config, pkgs, nixpkgs, ... }:

let
  user = "tanq";
in {
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

  programs.home-manager.enable = true;
}
