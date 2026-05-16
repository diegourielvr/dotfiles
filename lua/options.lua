-- Set <Space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.matchpairs = "(:),{:},[:],<:>"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.linebreak = true
vim.o.breakindent = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.guicursor = "n-v-c-sm:block-blinkwait900-blinkoff900-blinkon900,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait900-blinkoff400-blinkon200"

vim.o.scroll = 15

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.list = true
vim.opt.fillchars = {
    eob = ' ',
    vert = ' ',
    horiz = ' '
}
vim.opt.listchars = {
    tab = '  ',
    space = ' ',
    eol = ' ',
    lead = ' ',
    trail = '󱁐',
    nbsp = '󱁐'
}

vim.o.confirm = true
vim.o.swapfile = false
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.completeopt = "menuone,noselect,noinsert,preview"

vim.o.winborder = "rounded"
vim.o.pumheight = 15
vim.o.pumborder = "rounded"

vim.o.cmdheight = 1

vim.opt.diffopt:append 'followwrap,context:99'

vim.opt.shortmess:append {
    w = true,
    s = true,
}

-- vim.o.showmode = false


vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
