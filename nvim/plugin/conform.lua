vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	default_format_opts = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
		lsp_format = "fallback",
	},

	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		go = { "goimports" },
		lua = { "stylua" },
		typescript = { "oxfmt" },
		javascript = { "oxfmt" },
	},

	formatters = {

		["clang-format"] = {
			prepend_args = {
				"--style={BasedOnStyle: LLVM, IndentWidth: 4}",
			},
		},

		oxfmt = {
			require_cwd = false,
		},
	},

	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end
		return {
			timeout_ms = 500,
			lsp_fallback = true,
		}
	end,
})
