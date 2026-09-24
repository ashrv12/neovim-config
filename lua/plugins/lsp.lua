return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- Defaults applied to every language server. Must run before any server
        -- is enabled, which is what mason-lspconfig's setup() does below.
        -- nvim-lspconfig v2 no longer reads lspconfig.util.default_config; the
        -- native vim.lsp.config is the only thing that feeds the client now.
        --
        -- Deliberately does NOT enable workspace.didChangeWatchedFiles.
        -- dynamicRegistration. Neovim defaults it off; turning it on makes
        -- servers hand their watch globs to us, and Neovim's Linux backend then
        -- runs `inotifywait --recursive` over the entire project -- it filters
        -- events by glob but watches every directory regardless, build output
        -- included. Cargo's target/ churns through short-lived temp dirs, so
        -- inotifywait writes to stderr and every line becomes an error message
        -- ("inotify: Couldn't watch new directory ...") plus a hit-enter prompt.
        -- Left off, each server uses its own file watcher instead.
        vim.lsp.config("*", {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            ),
        })

        -- Configure error/warnings interface
        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.HINT] = "⚑",
                    [vim.diagnostic.severity.INFO] = "»",
                },
            },
        })

        local autoformat_filetypes = {
            "rust",
            "go",
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "zig",
            "ocaml",
            "ocamlinterface"
        }

        local format_group = vim.api.nvim_create_augroup("UserLspFormat", { clear = true })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                -- Format on save, but only for the one client that can do it,
                -- so two attached servers don't format the buffer twice.
                if
                    vim.tbl_contains(autoformat_filetypes, vim.bo[event.buf].filetype)
                    and client:supports_method("textDocument/formatting")
                then
                    vim.api.nvim_clear_autocmds({ group = format_group, buffer = event.buf })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = format_group,
                        buffer = event.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                formatting_options = { tabSize = 4, insertSpaces = true },
                                bufnr = event.buf,
                                id = client.id,
                            })
                        end,
                    })
                end

                -- Features that only work when a language server is attached
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
                end

                map("n", "K", vim.lsp.buf.hover, "LSP: hover documentation")
                map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
                map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
                map("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
                map("n", "go", vim.lsp.buf.type_definition, "LSP: go to type definition")
                map("n", "gr", vim.lsp.buf.references, "LSP: list references")
                map("n", "gs", vim.lsp.buf.signature_help, "LSP: signature help")
                map("n", "gl", vim.diagnostic.open_float, "LSP: show line diagnostics")
                map("n", "<F2>", vim.lsp.buf.rename, "LSP: rename symbol")
                map({ "n", "x" }, "<F3>", function()
                    vim.lsp.buf.format({ async = true })
                end, "LSP: format")
                map("n", "<F4>", vim.lsp.buf.code_action, "LSP: code action")

                if client.name == "ocamllsp" then
                    map("n", "<leader>oa", "<cmd>LspOcamllspSwitchImplIntf<cr>", "Ocaml: switch .ml/.mli")
                end
            end,
        })

        require("mason").setup({})
        -- mason-lspconfig 2.x dropped the `handlers` option. Installed servers
        -- are enabled automatically via vim.lsp.enable().
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "eslint",
                "rust_analyzer",
                "gopls",
                "zls",
            },
        })

        -- ocaml lsp enabled --
        vim.lsp.enable("ocamllsp")

        local cmp = require("cmp")

        require("luasnip.loaders.from_vscode").lazy_load()

        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        cmp.setup({
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "buffer",  keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == "nvim_lsp" then
                        item.menu = "[LSP]"
                    else
                        item.menu = string.format("[%s]", n)
                    end
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                -- scroll documentation window
                ["<C-f>"] = cmp.mapping.scroll_docs(5),
                ["<C-u>"] = cmp.mapping.scroll_docs(-5),

                -- toggle completion menu
                ["<C-e>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),

                -- tab complete
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1

                    if cmp.visible() then
                        cmp.select_next_item({ behavior = "select" })
                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),

                -- go to previous item
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),

                -- navigate to next snippet placeholder
                ["<C-d>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")

                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- navigate to the previous snippet placeholder
                ["<C-b>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")

                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
    end,
}
