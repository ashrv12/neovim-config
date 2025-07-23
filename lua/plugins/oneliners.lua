return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
        opts = {
            disable_filetype = {
                "TelescopePrompt",
                "spectre_panel",
                "snacks_picker_input",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
        },
    },
    { -- this helps with ssh tunneling and copying to clipboard
        "ojroques/vim-oscyank",
    },
    { -- git plugin
        "tpope/vim-fugitive",
    },
    { -- show css colors
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "html",
            "svelte",
            "tsx",
            "jsx",
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}
