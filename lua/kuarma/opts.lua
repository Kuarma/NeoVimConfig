-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local g = vim.g -- Global variables
local o = vim.o -- Set options
local opt = vim.opt -- Set options

-----------------------------------------------------------
-- General
-----------------------------------------------------------

o.mouse = "a"
o.cursorline = true
o.cursorlineopt = "number"
o.swapfile = false
o.completeopt = "menuone,noinsert,noselect"

-----------------------------------------------------------
-- General
-----------------------------------------------------------
o.number = true
o.showmatch = true
o.foldmethod = "marker"
o.foldenable = false
o.foldlevel = 90
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.linebreak = true
o.termguicolors = true
o.laststatus = 3

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
o.expandtab = true -- Use spaces instead of tabs
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
