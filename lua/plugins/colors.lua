local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
return {
    --    {
    -- "folke/tokyonight.nvim",
    -- config = function()
    --     vim.cmd.colorscheme "tokyonight"
    --     enable_transparency()
    -- end
    --    },
    -- { "datsfilipe/vesper.nvim" },
    -- {
    --     "ydkulks/cursor-dark.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         -- vim.cmd.colorscheme("cursor-dark-midnight")
    --         require("cursor-dark").setup({
    --             -- For theme
    --             style = "dark-midnight",
    --             -- For a transparent background
    --             transparent = true,
    --             -- If you have dashboard-nvim plugin installed
    --             dashboard = true,
    --         })
    --     end,
    -- },
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.cmd.colorscheme("oxocarbon")
            enable_transparency()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "tokyonight",
        },
    },
}
