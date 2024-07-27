require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
del("i", "<C-h>")
del("i", "<C-j>")
del("i", "<C-k>")
del("i", "<C-l>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "H", "^")
map("n", "L", "$")
map("n", "<leader>q", "<Cmd>qa<CR>", { desc = "Quit Window" })
map("n", "<C-a>", "ma<S-g><S-v>gg0", { desc = "Choose All" })
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
-- Switch buffers
map("n", "<C-h>", "<C-w>h", { desc = "Buffer switch left" })
map("n", "<C-l>", "<C-w>l", { desc = "Buffer switch right" })
map("n", "<C-j>", "<C-w>j", { desc = "Buffer switch down" })
map("n", "<C-k>", "<C-w>k", { desc = "Buffer switch up" })

-- Quick resize pane
map("n", "<C-A-h>", "5<C-w>>", { desc = "Window increase width by 5" })
map("n", "<C-A-l>", "5<C-w><", { desc = "Window decrease width by 5" })
map("n", "<C-A-k>", "5<C-w>+", { desc = "Window increase height by 5" })
map("n", "<C-A-j>", "5<C-w>-", { desc = "Window decrease height by 5" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Term escape terminal mode" })
-- noice
map("n", "<leader>fn", "<cmd>NoiceTelescope<cr>", { desc = "Telescope find noice" })
-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<C-p>", require("fzf-lua").files, { desc = "Fzf Files" })
map("n", "<leader>fm", "<cmd>Telescope zoxide list<cr>", { desc = "Find directories" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "Open file browser" })
