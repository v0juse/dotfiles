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

    "github/copilot.vim",
    "eandrju/cellular-automaton.nvim",
    "gpanders/editorconfig.nvim",
}

