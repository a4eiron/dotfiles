vim.pack.add({ "https://github.com/abecodes/tabout.nvim" })
vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
vim.pack.add({ "https://github.com/folke/flash.nvim" })
vim.pack.add({ "https://github.com/vimpostor/vim-tpipeline" })

require("tabout").setup()

require("which-key").setup({
	delay = 0,
	preset = "helix",
	win = {
		border = "single",
	},
})
