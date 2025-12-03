-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
local o = vim.opt

--o.clipboard = "unnamedplus"
o.termguicolors = true
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

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
}

o.scrolloff = 8
o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

o.updatetime = 50

o.title = true

o.showmode = false
o.winminwidth = 5

o.modifiable = true

o.showmatch = true
o.joinspaces = false
