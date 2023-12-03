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

