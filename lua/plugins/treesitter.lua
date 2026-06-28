return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- The main module is now just 'nvim-treesitter'
        local treesitter = require("nvim-treesitter")
        
        treesitter.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            -- Note: 'autotag' requires the 'nvim-ts-autotag' plugin
            -- autotag = { enable = true }, 
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

