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
vim.o.indent = true

vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'

vim.api.nvim_set_keymap("n", "<Leader> ", ":nohlsearch<CR>", {})
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<C-e>", ":Telescope live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {})

require'nvim-tree'.setup{}
