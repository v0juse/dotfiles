return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- LSP file operations for automatic refactoring on rename/move
        {
            "antosha417/nvim-lsp-file-operations",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                require("lsp-file-operations").setup()
            end,
        },
    },

    config = function()
        local oil = require("oil")

        oil.setup({
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
            default_file_explorer = true,
            -- Id is automatically added at the beginning, and name at the end
            columns = {
                "icon",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "nvic",
            },
            -- Skip the confirmation popup for simple operations
            skip_confirm_for_simple_edits = false,
            -- Prompt for confirmation when deleting
            prompt_save_on_select_new_entry = true,
            -- Oil will automatically delete hidden buffers after this delay
            cleanup_delay_ms = 2000,
            -- Keymaps in oil buffer
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-b>"] = "actions.close", -- Close oil with the same key
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = true,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- Natural sort order
                natural_order = true,
                is_always_hidden = function(name, bufnr)
                    return false
                end,
            },
            -- Configuration for floating window
            float = {
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for preview window
            preview = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = 0.9,
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
        })

        -- Toggle oil file explorer with <C-b>
        vim.keymap.set("n", "<C-b>", function()
            oil.toggle_float()
        end, { desc = "Toggle Oil file explorer" })
    end
}
