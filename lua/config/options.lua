vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Indentation: shiftwidth alone left tabstop at 8 and expandtab off, so the
-- editor disagreed with the LSP formatter (which is told tabSize=4, spaces).
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Rounded borders for floating windows. On 0.11+ this is a global option and
-- replaces overriding vim.lsp.handlers by hand.
vim.opt.winborder = "rounded"

-- True colour, required by rose-pine
vim.opt.termguicolors = true

-- Keep the sign column open so diagnostic signs don't shift the text
vim.opt.signcolumn = "yes"

-- Persistent undo across sessions
vim.opt.undofile = true

-- Case-insensitive search, unless the pattern contains a capital
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Open splits where you'd expect
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep some context around the cursor
vim.opt.scrolloff = 8

-- Treesitter folds are enabled per buffer, so start with everything unfolded
-- instead of opening every file fully collapsed.
vim.opt.foldlevelstart = 99

-- Share the system clipboard
vim.opt.clipboard = "unnamedplus"
