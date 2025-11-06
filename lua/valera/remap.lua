-- ==========================================================
-- Keymap configuration of kuarma
-- https://github.com/Kuarma/NeoVimConfig
-- ==========================================================

vim.g.mapleader = " "

-- ==========================================================
-- Helper functions
-- ==========================================================

-- Move current Window to a new tab
local function moveToNewTab()
	local current_Win = vim.api.nvim_get_current_win()
	vim.cmd("tab sb")
	vim.api.nvim_Win_close(current_win, false)
end

-- Select all text in buffer
local function selectAll()
	local bufnr = 0
	local end_line = vim.api.nvim_buf_line_count(bufnr)
	local curpos = vim.api.nvim_Win_get_cursor(0)
	local view = vim.fn.Winsaveview()

	vim.fn.setpos("'<", { bufnr, 1, 1, 0 })
	vim.fn.setpos("'>", { bufnr, end_line, 1000000, 0 })
	vim.cmd("normal! gv")

	vim.api.nvim_create_autocmd("ModeChanged", {
		pattern = { "v:n", "V:n", ":n" },
		once = true,
		callback = function()
			vim.api.nvim_Win_set_cursor(0, curpos)
			vim.fn.Winrestview(view)
		end,
	})
end

-- Get all popups
local function getPopups()
	return vim.fn.filter(vim.api.nvim_tabpage_list_Wins(0), function(_, e)
		return vim.api.nvim_Win_get_config(e).zindex
	end)
end

-- Kill floating Window / popups
local function killPopups()
	vim.fn.map(getPopups(), function(_, e)
		vim.api.nvim_Win_close(e, false)
	end)
end

-- Save session if open and execute a command
local function saveSessionIfOpen(cmd, hook_before)
	hook_before = hook_before or ""
	return function()
		if vim.g.persisting then
			vim.cmd("SessionSave")
		end
		local mode = vim.api.nvim_get_mode().mode
		if mode == 'i' then
			Ft("<Esc>l")
		end
		vim.cmd.noh()
		killPopups()
		if hook_before ~= "" then
			vim.cmd("wa!")
		end
		vim.cmd(cmd)
	end
end

-- Copy current file:line:col to register
local function copyFileLineCol()
	local file = vim.fn.expand('%')
	local line = vim.fn.line('.')
	local col = vim.fn.col('.')
	return string.format("%s:%d:%d", file, line, col)
end

-- Force go to file under cursor or create if missing
local function forceGoFile()
	local fname = vim.fn.expand("<cfile>")
	local path = vim.fn.expand("%:p:h") .. "/" .. fname
	if vim.fn.filereadable(path) ~= 1 then
		vim.cmd("silent! !touch " .. path)
	end
	vim.cmd.norm("gf")
end

-- ==========================================================
-- General / Miscellaneous
-- ==========================================================

K({ "n", "v" }, "-", "<cmd>Oil<cr>", { desc = "Open Oil" })
K("i", "<C-CR>", "<Esc>0", { desc = "Insert line above" })
K("i", "<C-del>", "X<Esc>ce", { desc = "Delete word forward" })
K("n", "<Space>p", '"p', { desc = "Paste from system clipboard" })
K("n", "<C-a>", selectAll, { desc = "Select all", overwrite = true })
K({ "", "i" }, "<A-w>", saveSessionIfOpen('w!'), { desc = "Save" })

K("n", "<space>y", "\"+y", { desc = "Yank to clipboard" })
K("v", "<space>y", "\"+y", { desc = "Yank to clipboard" })
K("x", "<space>p", "\"_dP", { desc = "Paste (preserve register)" })
K({ "n", "v" }, "<space>d", "\"_d", { desc = "Delete (to void)" })

K("n", "<Space>gf", forceGoFile, { desc = "Go to file (create if missing)" });
K("", "<Space>ay", function() vim.fn.setreg('"', copyFileLineCol()) end, { desc = "copy file:line:col to \" buffer" })

-- Clear search and kill popups
K("n", "<Esc>", function()
	vim.cmd.noh()
	killPopups()
	print(" ")
end, { desc = "Clear search and popups" })

-- select the pasted
K("n", "gp", function()
	return "`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]"
end, { desc = "Select pasted text", expr = true, overwrite = true })

-- ==========================================================
-- No operation
-- ==========================================================

K("", "<MiddleMouse>", "<nop>", { desc = "Nop" })
K('n', "<C-w><C-v>", "<nop>", { desc = 'Nop' })

-- ==========================================================
-- Movement
-- ==========================================================

-- Page scrolling (centered)
K("", "<C-d>", "<C-d>zz", { desc = "Page down (centered)", overwrite = true })
K("", "<C-u>", "<C-u>zz", { desc = "Page up (centered)", overwrite = true })

-- Move lines
K("", "<A-r>", "V:m '>+1<cr>gv=gv", { desc = "Move line down" })
K("", "<A-n>", "V:m '>-2<cr>gvegv", { desc = "Move line up" })

-- ==========================================================
-- Window & tab ctrl
-- ==========================================================

-- Window adjust width and height
K("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
K("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })
K("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
K("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Increase height" })

-- Tabs
K("n", "<C-w>k", moveToNewTab, { desc = "Move to new tab" })
K("n", '<C-w>v', '<cmd>tabprevious<cr>', { desc = 'Move to previously active tab' })
K("n", "<C-w>x", "<cmd>tabclose<cr>", { desc = "Close current tab" })
K("n", "<C-w>w", "<cmd>tabnext<cr>", { desc = "Go to next tab" })
K('', '<space>.', '<cmd>tabe .<cr>', { desc = "Open . in new tab" })

-- Navigating Tabs
K({ "i", "" }, "<A-l>", "<Esc>gT", { desc = "Previous tab" })
K({ "i", "" }, "<A-h>", "<Esc>gt", { desc = "Next tab" })
K({ "i", "" }, "<A-v>", "<Esc>g<Tab>", { desc = "Last visited tab" })

K({ "i", "" }, "<A-u>", "<Esc><cmd>tabmove -<cr>", { desc = "Tab move left" })
K({ "i", "" }, "<A-y>", "<Esc><cmd>tabmove +<cr>", { desc = "Tab move right" })
K({ "i", "" }, "<A-U>", "<Esc><cmd>tabmove 0<cr>", { desc = "Tab move first" })
K({ "i", "" }, "<A-Y>", "<Esc><cmd>tabmove $<cr>", { desc = "Tab move last" })

for i = 1, 8 do
	K("", '<A-' .. i .. '>', '<Esc><cmd>tabn ' .. i .. '<cr>', { desc = 'Tab ' .. i, silent = true })
	K("i", '<A-' .. i .. '>', '<Esc><cmd>tabn ' .. i .. '<cr>', { desc = 'Tab ' .. i, silent = true })
end

-- Close all
K({ "", "i" }, "<A-c>", "<cmd>q!<cr>", { desc = "Quit window" })
K({ "", "i" }, "<A-C>", "<cmd>tabdo bd<cr>", { desc = "Close all buffers" })
K({ "", "i" }, "<A-a>", saveSessionIfOpen('qa!', 'wa!'), { desc = "Save and quit all" })
K({ "", "i" }, "<A-;>", '<cmd>qa!<cr>', { desc = "Quit all" })
