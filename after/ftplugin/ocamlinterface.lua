vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Vim's ftplugin/ocaml.vim sets this for .ml files, but doesn't run for
-- the ocamlinterface filetype we have .mli files in options.lua
vim.opt_local.commentstring = "(* %s *)"
