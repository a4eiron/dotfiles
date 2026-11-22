vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			["vim.lsp.util.stylize_markdown"] = false,
			["cmp.entry.get_documentation"] = false,
		},
		hover = {
			enabled = false,
			silent = true,
		},
		signature = {
			enabled = false,
			auto_open = { enabled = false },
		},
	},
	presets = {
		lsp_doc_border = false,
	},
})
