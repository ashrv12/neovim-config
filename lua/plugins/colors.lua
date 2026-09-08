return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000, -- load the colorscheme before anything that highlights
        opts = {
            styles = {
                -- rose-pine's own transparency handles every background group,
                -- and survives a colorscheme reload. Setting Normal by hand did
                -- neither.
                transparency = true,
            },
        },
        config = function(_, opts)
            require("rose-pine").setup(opts)
            vim.cmd.colorscheme("rose-pine")
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
                theme = "rose-pine",
            },
        },
    },
}
