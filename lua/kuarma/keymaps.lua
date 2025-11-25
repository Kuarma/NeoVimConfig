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

		if mode == "i" then
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
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")

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
-- Oil
-- ==========================================================

K({ "n", "v" }, "-", "<cmd>Oil<cr>", { desc = "Open Oil" })
