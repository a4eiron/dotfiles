vim.loader.enable()

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.matchtime = 2
vim.opt.cmdheight = 0
vim.opt.winborder = "single"
vim.opt.laststatus = 3

vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

vim.opt.clipboard:append("unnamedplus")

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.diagnostic.config({
	underline = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- require("vim._core.ui2").enable()
