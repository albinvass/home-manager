{ config, pkgs, lib, ...}:
{
  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = [
      pkgs.tree-sitter
      pkgs.nil
      pkgs.lua-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      vim-surround
      gruvbox
      vimagit
      vim-fugitive
      vim-rooter
      popup-nvim
      plenary-nvim
      nvim-lspconfig
      telescope-nvim
      vim-snippets
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      nvim-cmp
      luasnip
      cmp_luasnip
      nvim-treesitter.withAllGrammars
      nvim-tree-lua
      nvim-web-devicons
      nvim-FeMaco-lua
    ];

    # Automatically require all toplevel lua scripts
    extraLuaConfig =
      let
        luaFiles = 
          let
            luaDir = builtins.readDir ./nvim/lua;
            onlyFiles = (n: v: v == "regular");
          in builtins.attrNames (lib.attrsets.filterAttrs onlyFiles luaDir);
        mkRequire = (path: 
          let
            filePath = toString path;
            requireName = lib.strings.removeSuffix ''.lua'' filePath;
          in "require'${requireName}'");
      in lib.strings.concatMapStrings (s: s + "\n") (map mkRequire luaFiles);
  };
}
