{ pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = [
      pkgs.tree-sitter
      pkgs.rnix-lsp
      pkgs.nil
    ];
    extraLuaConfig = /* lua */ ''
      vim.cmd 'colorscheme gruvbox'
      vim.o.background = "dark"
      vim.o.number = true
      vim.o.showcmd = true
      vim.o.cursorline = true
      vim.o.wildmenu = true
      vim.o.lazyredraw = true
      vim.o.showmatch = true
      vim.o.hlsearch = true
      vim.o.colorcolumn = 80
      vim.o.mouse = nil
      vim.g.mapleader = ","

      vim.api.nvim_set_keymap("n", "<Leader> ", ":nohlsearch<CR>", {})
      vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", {})
      vim.api.nvim_set_keymap("n", "<C-e>", ":Telescope live_grep<CR>", {})
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {})

      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true
        },
      }
      require'nvim-tree'.setup{}

      local cmp = require'cmp'

      cmp.setup({
          snippet = {
              expand = function(args)
                  require('luasnip').lsp_expand(args.body)
              end,
          },
          mapping = cmp.mapping.preset.insert({
              ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                      cmp.select_next_item()
                  --elseif vim.fn["vsnip#available"](1) == 1 then
                  --    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                  else
                      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                  end
              end, { "i", "s" }),

              ["<S-Tab>"] = cmp.mapping(function()
                  if cmp.visible() then
                      cmp.select_prev_item()
                  --elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                  --    feedkey("<Plug>(vsnip-jump-prev)", "")
                  end
              end, { "i", "s" }),

              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              --{ name = 'cmp_tabnine' }
          }, {
              { name = 'buffer' },
          })
      })

      local nvim_lsp = require('lspconfig')

      local servers = {
          lua_ls={},
          nil_ls={},
          pylsp={},
          bashls={},
          --dockerls={},
          clangd={},
          terraformls={_on_attach=function()
                  vim.api.nvim_create_autocmd({"BufWritePre"}, {
                      pattern = {"*.tf", "*.tfvars"},
                      callback = vim.lsp.buf.formatting_sync
                  })
              end
          },
      }

      for lsp, conf in pairs(servers) do
          conf['on_attach'] = function()
              if conf['_on_attach'] ~= nil then
                  conf._on_attach()
              end
          end
          conf['flags'] = {
              debounce_text_changes = 150,
          }
          nvim_lsp[lsp].setup(conf)
      end
    '';
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
      #vim-terraform
      #vim-nix
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
    ];
  };
}
