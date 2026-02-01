return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        -- Use gb to add cursors by selecting the word under the cursor.
        vim.g.VM_maps = vim.tbl_extend("force", vim.g.VM_maps or {}, {
            ["Find Under"] = "gb",
            ["Find Subword Under"] = "gb",
        })
    end,
}
