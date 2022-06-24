{ config, pkgs, nixpkgs, ... }:

{
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
        psgrep = "ps aux | grep";

        ws1 = "i3-msg workspace \"1\";";
        ws2 = "i3-msg workspace \"2\";";
        ws3 = "i3-msg workspace \"3\";";
        ws4 = "i3-msg workspace \"4\";";
        ws5 = "i3-msg workspace \"5\";";
        ws6 = "i3-msg workspace \"6\";";
        ws7 = "i3-msg workspace \"7\";";
        ws8 = "i3-msg workspace \"8\";";
        ws9 = "i3-msg workspace \"9\";";
        ws10 = "i3-msg workspace \"10\";";
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

    vscode = {
      enable = true;
      extensions = with pkgs; [ 
        vscode-extensions.golang.go
        vscode-extensions.vscodevim.vim
        vscode-extensions.github.copilot
        vscode-extensions.eamodio.gitlens
      ];
    };
  };
}
