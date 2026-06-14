vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	picker = { enabled = true },
	explorer = { enabled = true },
	notifier = { enabled = true, timeout = 3000 },
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	indent = { enabled = true },
	input = { enabled = true },
	terminal = { enabled = false },
	words = { enabled = true },
})
