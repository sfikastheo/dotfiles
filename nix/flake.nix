{
  description = "System Flake (Linux)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        cliTools = with pkgs; [
            fd
            fzf
            direnv
            ripgrep
        ];

        langTools = with pkgs; [
            go
            zig
            zls
            bun
            gopls
            rustup
    	    nodejs_23
            lua-language-server
            typescript-language-server
        ];

        devTools = with pkgs; [
            lsd
            tmux
            zellij
            neovim
            zoxide
            starship
        ];
      in
      {
        packages.default = pkgs.buildEnv {
          name = "system-flake";
          paths = cliTools ++ langTools ++ devTools;
        };
      }
    );
}
