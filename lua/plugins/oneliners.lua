return {
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
        end
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
}
