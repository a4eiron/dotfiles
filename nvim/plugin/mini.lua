vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.basics").setup({
	options = { basic = true, extra_ui = false },
	mappings = { basic = true, windows = true },
	autocommands = { basic = true, relnum_in_visual_mode = true },
})

require("mini.pairs").setup()

require("mini.icons").setup()
local icons = require("mini.icons")
icons.mock_nvim_web_devicons()

-- require("mini.tabline").setup({
-- 	format = function(buf_id, label)
-- 		local suffix = vim.bo[buf_id].modified and "+ " or "  "
-- 		return "  " .. require("mini.tabline").default_format(buf_id, label) .. suffix
-- 	end,
-- })

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			mode = mode:upper()
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local filename = MiniStatusline.section_filename({ trunc_width = 100 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git } },
				{ hl = "", strings = { filename } },
				"%=",
				{ hl = "", strings = { diagnostics } },
				{ hl = "MiniStatuslineDevinfo", strings = { lsp } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

require("mini.cursorword").setup()
require("mini.surround").setup()
