vim.g.mapleader = " "
-- Open parent directory in oil (replaces netrw)
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- maybe someday
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- used to copy the hole line like this
vim.keymap.set("n", "Y", "yy")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-e>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-w>", "<cmd>bdelete<CR>")

-- Window management
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Next window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
vim.keymap.set("n", "<leader>w<left>", "<C-w><", { desc = "Decrease width" })
vim.keymap.set("n", "<leader>w<right>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<leader>w<up>", "<C-w>+", { desc = "Increase height" })
vim.keymap.set("n", "<leader>w<down>", "<C-w>-", { desc = "Decrease height" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Quit window" })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<C-f>", vim.lsp.buf.format)

vim.keymap.set("n", "<C-S-K>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-S-J>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/voidev/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>rs", "<cmd>bufdo bwipeout<CR>");
vim.keymap.set("n", "<c-k>w", "<cmd>bufdo bwipeout<CR><cmd>Alpha<CR>");
--
-- goes back and forth like weee
vim.keymap.set("n", "H", "<C-o>")
vim.keymap.set("n", "L", "<C-i>")

vim.keymap.set("n", "<c-k>c", function()
    local filepath = vim.fn.expand('%:p')
    vim.fn.setreg('+', filepath)
    vim.notify('Copied: ' .. filepath)
end, { desc = "Copy current file path" })

vim.keymap.set({ "n", "v" }, "<c-k><s-c>", function()
    local filepath = vim.fn.expand('%:p')
    local line_info
    if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        line_info = start_line .. '-' .. end_line
    else
        line_info = vim.fn.line('.')
    end
    local result = filepath .. ':' .. line_info
    vim.fn.setreg('+', result)
    vim.notify('Copied: ' .. result)
end, { desc = "Copy file with line markers" })
