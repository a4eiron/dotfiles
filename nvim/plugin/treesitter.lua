vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ensure_installed = {
	"bash",
	"c",
	"cpp",
	"gitignore",
	"go",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"python",
	"rust",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

require("nvim-treesitter").install(ensure_installed)
