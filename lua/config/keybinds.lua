vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Open file explorer" })

-- Escape from insert mode. These were set with noremap = false, which made them
-- recursive mappings for no reason.
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
