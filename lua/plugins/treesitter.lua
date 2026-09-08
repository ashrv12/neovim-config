-- nvim-treesitter `main` branch: setup() only takes `install_dir`. Parsers are
-- installed with install(), and highlight/indent/fold are enabled per buffer by
-- Neovim itself -- the old `highlight = { enable = true }` style opts are gone.
local ensure_installed = {
    "lua",
    "go",
    "gomod",
    "gosum",
    "helm",
    "html",
    "json",
    "nginx",
    "python",
    "ruby",
    "sql",
    "zig",
    "typescript",
    "tsx",
    "javascript",
    "rust",
    "svelte",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- this plugin does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({})
        require("nvim-treesitter").install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
            callback = function(args)
                -- Fails when no parser is installed for this filetype, which is
                -- the normal case for plenty of buffers.
                if not pcall(vim.treesitter.start, args.buf) then
                    return
                end

                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
            end,
        })
    end,
}
