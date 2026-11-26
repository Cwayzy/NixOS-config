{ inputs, ... }: {
  flake.modules.homeManager.nvim = { config, lib, pkgs, ... }:
  let
    nvimDir = "${config.home.homeDirectory}/.dotfiles/modules/user/nvim/config";
  in {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = false;
      withRuby = false;
      withPython3 = false;

      extraPackages = with pkgs; [
        ripgrep fd fzf lazygit trash-cli git curl unzip
        gcc tree-sitter
        python3 uv
        ruff basedpyright lua-language-server stylua shfmt nixd nixfmt
      ];
    };

    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink nvimDir;

    # Seed LazyVim into the repo dir only if it doesn't have a config yet
    home.activation.seedLazyVim =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -e "${nvimDir}/init.lua" ]; then
          run mkdir -p "${nvimDir}"
          run cp -r --no-preserve=mode,ownership \
            "${inputs.lazyvim-starter}/." "${nvimDir}/"
          run rm -rf "${nvimDir}/.git"
        fi
      '';
  };
}
