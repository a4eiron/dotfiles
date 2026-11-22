vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

require("which-key").setup()
require("todo-comments").setup()
