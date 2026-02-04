return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                themable = true,
                numbers = "ordinal",
                close_command = "bdelete! %d",
                indicator = {
                    style = "icon",
                    icon = "▎",
                },
                buffer_close_icon = "󰅖",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 30,
                max_prefix_length = 15,
                truncate_names = true,
                tab_size = 18,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "oil",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true
                    }
                },
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,
                separator_style = "thin",
                always_show_bufferline = false, -- Only show when multiple buffers
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" }
                },
            },
        })

        -- Buffer navigation keymaps
        -- <C-Tab> and <C-S-Tab> to cycle through buffers
        vim.keymap.set("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

        -- Also support in insert mode for convenience
        vim.keymap.set("i", "<C-Tab>", "<Esc><cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("n", "<leader>q", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("i", "<C-S-Tab>", "<Esc><cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

        -- Pick buffer with floating picker (VS Code style)
        vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "[B]uffer [P]ick" })
        vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "[B]uffer Pick [C]lose" })

        -- Move buffers in the tabline
        vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineMoveNext<CR>", { desc = "[B]uffer Move [N]ext" })
        vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineMovePrev<CR>", { desc = "[B]uffer Move [P]rev" })

        -- Go to buffer by ordinal number
        vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
        vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
        vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
        vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
        vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
        vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
        vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
        vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
        vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })

        -- Close current buffer
        vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [D]elete" })
    end,
}
