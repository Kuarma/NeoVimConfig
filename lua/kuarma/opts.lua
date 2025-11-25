-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local o = vim.opt
local g = vim.g

o.clipboard = "unnamedplus"
o.wrap = false
o.splitright = true
o.splitbelow = true
o.showtabline = 2

o.relativenumber = false
o.number = true
o.cursorlineopt = "both"

o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.var/undodir"

o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.tabstop = 2
o.softtabstop = 0
o.shiftwidth = 2
o.expandtab = false
o.smartindent = true
g.autoformat = true

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }

o.scrolloff = 5
o.signcolumn = "yes"

o.updatetime = 50

o.title = true

o.showmode = false
o.winminwidth = 5

o.modifiable = true

o.showmatch = true
o.joinspaces = false

o.spelloptions = "camel"
o.spellcapcheck = ""

o.spellfile = os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add"
