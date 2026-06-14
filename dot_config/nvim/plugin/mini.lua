vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.tabline").setup()
require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			-- mode = mode:sub(1, 1)
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
			local location = "%2l:%-2v"
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { "◉" } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff } },
				{ hl = "", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineDevinfo", strings = { diagnostics, lsp } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
	},
	use_icons = true,
	set_vim_settings = true,
})
