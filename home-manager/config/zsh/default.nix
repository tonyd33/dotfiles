{  pkgs, ... }:
{
    programs.zsh = {
        enable           = true;
        enableCompletion = true;

        oh-my-zsh = {
            enable  = true;
            theme   = "fwalch";
            plugins = [
                "colored-man-pages"
                "colorize"
                "fzf" # cmd history
            ];
        };

        plugins = [
            {
                name = "zsh-nix-shell";
                file = "nix-shell.plugin.zsh";

                src = pkgs.fetchFromGitHub {
                    owner  = "chisui";
                    repo   = "zsh-nix-shell";
                    rev    = "v0.8.0";
                    sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
                };
            }
            {
                name = "zsh-fzf-tab";
                file = "share/fzf-tab/fzf-tab.plugin.zsh";
                src  = pkgs.zsh-fzf-tab;
            }
        ];
    };
}
