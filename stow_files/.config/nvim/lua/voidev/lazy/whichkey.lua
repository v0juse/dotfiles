return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")

        wk.setup({
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            win = {
                border = "rounded",
                padding = { 2, 2, 2, 2 },
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            show_help = true,
            show_keys = true,
        })

        -- Register key groups with descriptions
        wk.add({
            -- Leader key groups
            { "<leader>f", group = "Find/Files" },
            { "<leader>s", group = "Search/Substitute" },
            { "<leader>p", group = "Project" },
            { "<leader>l", group = "LSP" },
            { "<leader>v", group = "Vim/Config" },
            { "<leader>z", group = "Zen Mode" },
            { "<leader>n", group = "Neogen" },
            { "<leader>t", group = "Test/Trouble" },
            { "<leader>g", group = "Git" },
            { "<leader>w", group = "Window" },

            -- Individual mappings with descriptions (from remap.lua)
            { "<leader>pv", desc = "Open parent directory (Oil)" },
            { "<leader>vwm", desc = "Start Vim With Me" },
            { "<leader>svwm", desc = "Stop Vim With Me" },
            { "<leader>y", desc = "Yank to system clipboard" },
            { "<leader>Y", desc = "Yank line to system clipboard" },
            { "<leader>d", desc = "Delete to void register" },
            { "<leader>k", desc = "Next location list item" },
            { "<leader>j", desc = "Prev location list item" },
            { "<leader>x", desc = "Make file executable" },
            { "<leader>ee", desc = "Insert Go error handling" },
            { "<leader>vpp", desc = "Edit packer config" },
            { "<leader>mr", desc = "Cellular Automaton rain" },
            { "<leader><leader>", desc = "Source current file" },
            { "<leader>rs", desc = "Close all buffers" },
            { "<leader>u", desc = "Toggle Undotree" },
            { "<leader>uc", desc = "Toggle env secret cloak" },

            -- Telescope mappings (from telescope.lua)
            { "<leader>ff", desc = "Find files" },
            { "<leader>fg", desc = "Find git files" },
            { "<leader>fr", desc = "Find recent files" },
            { "<leader>fb", desc = "Find buffers" },
            { "<leader>sg", desc = "Search with grep" },
            { "<leader>sw", desc = "Search word under cursor" },
            { "<leader>pfg", desc = "Project find git files" },
            { "<leader>pws", desc = "Project word search" },
            { "<leader>pWs", desc = "Project WORD search" },
            { "<leader>ps", desc = "Project search (grep)" },
            { "<leader>vh", desc = "Vim help tags" },

            -- Git/Fugitive mappings (from fugitive.lua)
            { "<leader>gs", desc = "Git status" },

            -- LSP mappings (from init.lua LspAttach)
            { "<leader>lws", desc = "Workspace symbols" },
            { "<leader>ld", desc = "Diagnostic float" },
            { "<leader>lca", desc = "Code action" },
            { "<leader>lrr", desc = "References" },
            { "<leader>lrn", desc = "Rename" },

            -- Trouble mappings (from trouble.lua)
            { "<leader>tt", desc = "Toggle Trouble" },

            -- Zen mode mappings (from zenmode.lua)
            { "<leader>zz", desc = "Zen mode (with numbers)" },
            { "<leader>zZ", desc = "Zen mode (no numbers)" },

            -- Neogen mappings (from neogen.lua)
            { "<leader>nf", desc = "Generate function doc" },
            { "<leader>nt", desc = "Generate type doc" },

            -- Neotest mappings (from neotest.lua)
            { "<leader>tc", desc = "Run nearest test" },
            { "<leader>tf", desc = "Run file tests" },

            -- Non-leader mappings with descriptions
            { "gd", desc = "Go to definition" },
            { "gh", desc = "Hover documentation" },
            { "gu", desc = "Diffget //2" },
            { "[d", desc = "Next diagnostic" },
            { "]d", desc = "Prev diagnostic" },
            { "[t", desc = "Next trouble item" },
            { "]t", desc = "Prev trouble item" },
            { "H", desc = "Jump back (Ctrl-O)" },
            { "L", desc = "Jump forward (Ctrl-I)" },
            { "Y", desc = "Yank entire line" },
            { "J", desc = "Join lines (keep cursor)" },
            { "n", desc = "Next search (centered)" },
            { "N", desc = "Prev search (centered)" },
            { "Q", desc = "Disabled (nop)" },
            { "gb", desc = "Add cursor (Visual Multi)" },

            -- Visual mode mappings
            { mode = "v", "<leader>p", desc = "Paste without yanking" },
            { mode = "v", "<leader>y", desc = "Yank to system clipboard" },
            { mode = "v", "<leader>d", desc = "Delete to void register" },
            { mode = "v", "J", desc = "Move selection down" },
            { mode = "v", "K", desc = "Move selection up" },
        })
    end,
}
