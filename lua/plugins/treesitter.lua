return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,

            },
            indent = { enable = true },
            autotage = { enable = true },
            ensure_installed = {
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
                "rust",
                "svelte",
            },
            auto_install = false,
        })
    end
}
