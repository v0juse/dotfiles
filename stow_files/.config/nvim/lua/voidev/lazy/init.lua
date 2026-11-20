return {

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    -- Icon providers
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            require("mini.icons").setup()
        end,
    },
    "nvim-tree/nvim-web-devicons",

    {
        "github/copilot.vim",
        init = function()
            -- cmd.exe mangles the default "npx ...@^x.y" version spec on Windows
            if vim.fn.has("win32") == 1 then vim.g.copilot_version = "latest" end
        end,
    },
    "eandrju/cellular-automaton.nvim",
    "gpanders/editorconfig.nvim",
}

