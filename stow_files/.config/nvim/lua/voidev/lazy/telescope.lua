return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        local keymap = vim.keymap
        keymap.set('n', '<C-p>', builtin.find_files, {})
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {desc = "[F]ind [F]iles"})
        keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", {desc = "[F]ind [G]it Files"})
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {desc = "[F]ind [R]ecent Files"})
        keymap.set('n', "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind existing [B]uffers"})
        keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", {desc = "[S]earch [G]rep"})
        keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", {desc = "[S]earch [W]ord Under Cursor"})
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

