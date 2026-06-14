vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	format_on_save = function(bufnr)
		local enabled_filetypes = {
			lua = true,
			go = true,
			cpp = true,
			rust = true,
			javascript = true,
			typescript = true,
			python = true,
			json = true,
		}
		if enabled_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd" },
		javascript = { "prettierd" },
		json = { "prettierd" },
		python = { "black" },
	},
})
