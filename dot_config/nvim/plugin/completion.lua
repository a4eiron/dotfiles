vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })
vim.pack.add({ { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") } })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = {},
		["<S-Tab>"] = {},
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		ghost_text = { enabled = true },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			draw = {
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
	},
	sources = {
		default = { "lsp", "snippets", "buffer", "path" },
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
})
