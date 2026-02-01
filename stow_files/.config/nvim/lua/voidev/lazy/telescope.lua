return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local actions = require("telescope.actions")
        local builtin = require('telescope.builtin')

        -- Neovim nightly (0.11+) removed `vim.treesitter.language.ft_to_lang`;
        -- provide a shim so Telescope previewers keep syntax highlighting.
        local ok, ts_language = pcall(require, "vim.treesitter.language")
        if ok and ts_language and not ts_language.ft_to_lang then
            ts_language.ft_to_lang = function(ft)
                return require("nvim-treesitter.parsers").ft_to_lang(ft)
            end
        end

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    }
                }
            }
        })

        local show_hidden = false

        local function toggle_hidden()
            show_hidden = not show_hidden
            vim.notify("Telescope hidden files: " .. (show_hidden and "on" or "off"), vim.log.levels.INFO)
        end

        local function find_files()
            builtin.find_files({ hidden = show_hidden, no_ignore = show_hidden })
        end

        local keymap = vim.keymap
        keymap.set('n', '<C-p>', builtin.find_files, {})
        keymap.set("n", "<leader>ff", find_files, { desc = "[F]ind [F]iles" })
        keymap.set("n", "<leader>fh", function()
            toggle_hidden()
            find_files()
        end, { desc = "Toggle hidden files and search" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "[F]ind [G]it Files" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecent Files" })
        keymap.set('n', "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind existing [B]uffers" })
        keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch [G]rep" })
        keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[S]earch [W]ord Under Cursor" })
        vim.keymap.set('n', '<leader>pfg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
