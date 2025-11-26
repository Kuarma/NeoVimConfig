-- ==========================================================
-- Keymap configuration of kuarma
-- https://github.com/Kuarma/NeoVimConfig
-- ==========================================================

local set = vim.keymap.set

vim.g.mapleader = " "

-- Oil
set({ "n", "v" }, "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Copy & Paste
set({ "v", "n" }, "<space>y", '"+y', { desc = "Yank to clipboard" })
set("n", "<space>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Tabs
set("n", "<A-h>", "<Esc>gT", { desc = "Tab prev" })
set("n", "<A-l>", "<Esc>gt", { desc = "Tab next" })
set("n", "<A-v>", "<Esc>g<Tab>", { desc = "Tab last visited" })
set("n", "<A-0>", "<Esc><cmd>tablast<cr>", { desc = "Tab last" })
set({ "i", "n" }, "<A-u>", "<Esc><cmd>tabmove -<cr>", { desc = "Tab move left" })
set({ "i", "n" }, "<A-y>", "<Esc><cmd>tabmove +<cr>", { desc = "Tab move right" })
set({ "i", "n" }, "<A-U>", "<Esc><cmd>tabmove 0<cr>", { desc = "Tab move first" })
set({ "i", "n" }, "<A-Y>", "<Esc><cmd>tabmove $<cr>", { desc = "Tab move last" })
set({ "i", "n" }, "<space>.", "<cmd>tabe .<cr>", { desc = "Open . in new tab" })

for i = 1, 9 do
	set({ "n", "i" }, "<A-" .. i .. ">", "<Esc><cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end
