local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Focus window left", silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Focus window up", silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Focus window down", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Focus window right", silent = true })

map("t", "<ESC><ESC>", "<C-\\><C-n>")
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Focus window left" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Focus window up" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Focus window down" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Focus window right" })

map("n", "<leader>tv", ":vsplit | term<CR>", { desc = "Vertical Terminal", silent = true })
map("n", "<leader>th", ":split | term<CR>", { desc = "Horizontal Terminal", silent = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up", silent = true })

map("v", "<", "<gv", { desc = "Indent left", silent = true })
map("v", ">", ">gv", { desc = "Indent right", silent = true })

map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical", silent = true })
map("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal", silent = true })

map("n", "<leader>w", ":write<CR>", { desc = "Write buffer", silent = true })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit window", silent = true })

map("n", "<TAB>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
map("n", "<S-TAB>", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })

map("n", "<ESC>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

map("n", "\\d", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics", silent = true })
