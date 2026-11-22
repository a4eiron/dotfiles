vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},

		menu = {
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon", "label", gap = 1 },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
				},
			},
		},

		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},

		ghost_text = {
			enabled = true,
		},
	},

	keymap = {
		preset = "enter",
	},
})
