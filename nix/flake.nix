{
  description = "Develeopment flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        cliTools = with pkgs; [
          fd
          fzf
          git
          delta
          direnv
          git-lfs
          ripgrep
        ];

        langTools = with pkgs; [
          go
          zig
          zls
          bun
          gopls
          rustup
          nodejs_24
          nixfmt-rfc-style
          lua-language-server
          typescript-language-server
        ];

        devTools = with pkgs; [
          lsd
          tmux
          btop
          yazi
          helix
          zellij
          neovim
          zoxide
          lazygit
          starship
          yaziPlugins.git
          yaziPlugins.diff
          yaziPlugins.jump-to-char
        ];

        world = with pkgs; [
          mongosh
          teleport_16
        ];

      in
      {
        packages = {
          system = pkgs.buildEnv {
            name = "system";
            paths = cliTools ++ langTools ++ devTools ++ world;
            ignoreCollisions = true;
          };

          devbox = pkgs.buildEnv {
            name = "devbox";
            paths = cliTools ++ langTools ++ devTools;
            ignoreCollisions = true;
          };

          minimal = pkgs.buildEnv {
            name = "minimal";
            paths = cliTools ++ [ pkgs.neovim ];
          };

          remote = pkgs.buildEnv {
            name = "remote";
            paths = cliTools;
          };
        };
      }
    );
}
