{ config, pkgs, nixpkgs, ... }:

{
    imports = [
        ./home.nix
        ./programs.nix
    ];
}
