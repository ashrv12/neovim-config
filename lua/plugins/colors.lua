return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000, -- load the colorscheme before anything that highlights
        config = function()
            vim.g.sonokai_style = "default"
            vim.g.sonokai_transparent_background = 2
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_better_performance = 1
            vim.cmd.colorscheme("sonokai")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- lualine reads the theme from `options.theme`; a top-level `theme`
            -- key was silently ignored (and tokyonight isn't installed).
            options = {
                theme = "sonokai",
            },
        },
    },
}
