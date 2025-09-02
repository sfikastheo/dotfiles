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
          uv
          zig
          zls
          bun
          nixd
          ruff
          gopls
          isort
          taplo
          black
          rustup
          prettierd
          nodejs_24
          clang-tools
          nixfmt-rfc-style
          lua-language-server
          typescript-language-server
        ];

        devTools = with pkgs; [
          lsd
          tmux
          btop
          helix
          zellij
          neovim
          zoxide
          lazygit
          starship
        ];

        world = with pkgs; [
          cachix
          mongosh
          teleport_16
        ];

      in
      {
        packages = {
          default = pkgs.buildEnv {
            name = "default";
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
