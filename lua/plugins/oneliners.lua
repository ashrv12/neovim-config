return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
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

        config = function(_, opts)
            local npairs = require("nvim-autopairs")
            npairs.setup(opts)
            
            -- ' starts type variables ('a) in OCaml, not just char literals.
            -- Append rather than replace: this rule already excludes rust/nix.
            local quote = npairs.get_rules("'")[1]
            table.insert(quote.not_filetypes, "ocaml")
            table.insert(quote.not_filetypes, "ocamlinterface")

            npairs.force_attach()
        end,
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
}
