{ config, pkgs, nixpkgs, user, ... }:

{
    imports = [
        ./home.nix
        ./programs.nix
        ./services.nix
    ];
}
