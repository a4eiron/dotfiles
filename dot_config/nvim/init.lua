-- Customized from https://github.com/nvim-lua/kickstart.nvim
-- Thank you :)

vim.loader.enable()

vim.g.mapleader = " "

local opt = vim.o

opt.number = true
opt.relativenumber = true
opt.breakindent = true
opt.undofile = true
opt.cursorline = true
opt.scrolloff = 10
opt.showmode = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.inccommand = "split"
opt.signcolumn = "yes"
opt.winborder = "single"
opt.confirm = true
opt.splitright = true
opt.splitbelow = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.termguicolors = true
opt.cmdheight = 0
opt.laststatus = 3
opt.autoread = true
opt.autowrite = true
opt.swapfile = false
opt.backupcopy = "yes"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { desc = "Move focus to the left window" })
map("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { desc = "Move focus to the right window" })
map("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { desc = "Move focus to the lower window" })
map("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
map("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<CR>")
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Toggle Line Wrap
map("n", "<A-z>", function()
	vim.wo.wrap = not vim.wo.wrap
	vim.wo.linebreak = vim.wo.wrap

	local status = vim.wo.wrap and "Enabled" or "Disabled"
	vim.notify("Line wrap " .. status, vim.log.levels.INFO, { title = "UI" })
end, { desc = "Toggle line wrap" })

-- Terminal
map({ "n", "t" }, "<C-`>", function()
	require("nvterm.terminal").toggle("horizontal")
end, { desc = "Toggle horizontal terminal" })
map({ "n" }, "<leader>tv", function()
	require("nvterm.terminal").toggle("vertical")
end, { desc = "Toggle vertical terminal" })
map({ "n" }, "<leader>tf", function()
	require("nvterm.terminal").toggle("float")
end, { desc = "Toggle floating terminal" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Quickfix List Navigation Quick-keys
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

-- Snacks
map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Open File Explorer" })
map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep Project Workspace" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Grep Project Workspace" })
map("n", "<leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep Current Word" })
map("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "Workspace Diagnostics" })
map("n", "<leader><leader>", function()
	Snacks.picker.buffers()
end, { desc = "Switch Buffers" })
map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
map("n", "<leader>ut", function()
	Snacks.picker.colorschemes()
end, { desc = "Select Colorscheme" })

-- Flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash Jump" })

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter Scope" })

map("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search Embedding" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "single", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

map("n", "L", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/vague-theme/vague.nvim",
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	"https://github.com/NvChad/nvterm",
})

require("tokyonight").setup({
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
	},
})
require("vague").setup({ transparent = true })

require("nvterm").setup({
	terminals = {
		shell = vim.o.shell,
		list = {},
		type_opts = {
			float = {
				relative = "editor",
				row = 0.3,
				col = 0.25,
				width = 0.5,
				height = 0.6,
				border = "single",
			},
			horizontal = { location = "rightbelow", split_ratio = 0.4 },
			vertical = { location = "rightbelow", split_ratio = 0.5 },
		},
	},
	behavior = {
		autoclose_on_quit = {
			enabled = false,
			confirm = true,
		},
		close_on_exit = true,
		auto_insert = true,
	},
})

vim.cmd.colorscheme("tokyonight-night")
