{ pkgs, ... }:
let
    vimrc = import ./vimrc.nix { pkgs = pkgs; };
in {
    environment = {
        variables = { EDITOR = "vim"; };
        systemPackages = with pkgs; [
            (vim_configurable.customize {
                name = "vim";
                vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
                    start = [
                        nerdtree
                        nerdtree-git-plugin
                        vim-nerdtree-tabs
                        vim-nix
                        vim-lastplace
                        vim-commentary
                        vim-fugitive
                        vim-gitgutter
                        delimitMate
                        tagbar
                        ale
                        vim-polyglot
                        vim-rhubarb 
                        ayu-vim
                        vim-easymotion
                        fzf-vim
                        ultisnips
                        vim-snippets
                        vim-go
                    ];
                    opt = [];
                };
                vimrcConfig.customRC = vimrc.config;
            })
        ];
    };
}