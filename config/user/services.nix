{ config, pkgs, nixpkgs, ... }:

{
    services = {
        polybar.enable = true;
        polybar.script = "$HOME/.config/polybar/launch.sh";
        picom = {
            enable = true;
            backend = "glx";
            activeOpacity = "1.0";
            inactiveOpacity = "0.8";
        };
    };
}