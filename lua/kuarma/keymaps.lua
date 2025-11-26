-- ==========================================================
-- Keymap configuration of kuarma
-- https://github.com/Kuarma/NeoVimConfig
-- ==========================================================

vim.g.mapleader = " "

-- ==========================================================
-- Plugins
-- ==========================================================
vim.keymap.set({ "n", "v" }, "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set({ "n", "v" }, "<c-h>", "<CMD>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
