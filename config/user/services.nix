{ config, pkgs, nixpkgs, ... }:

{
    services = {
        polybar.enable = true;
        polybar.script = "$HOME/.config/polybar/launch.sh";
    };
}