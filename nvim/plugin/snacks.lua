vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	explorer = { enabled = true },
	indent = {
		indent = {
			enabled = true,
			char = "▏",
		},
		scope = {
			enabled = true,
			char = "▏",
		},
	},
	input = { enabled = true },
	scroll = { enabled = false },
	picker = {
		enabled = true,
		sources = {
			explorer = {
				layout = {
					layout = {
						position = "left",
						width = 30,
					},
				},
			},
			files = { hidden = true },
			grep = { hidden = true },
		},
	},
	notifier = { enabled = false },
	statuscolumn = { enabled = false },
})

local map = vim.keymap.set
local snacks = require("snacks")

map("n", "<leader>e", snacks.picker.explorer, { desc = "File explorer" })
map("n", "<leader>ff", snacks.picker.files, { desc = "Find files" })
map("n", "<leader>fr", snacks.picker.recent, { desc = "Recent files" })
map("n", "<leader>fg", snacks.picker.grep, { desc = "Grep" })
map("n", "<leader><leader>", snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>fd", snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fh", snacks.picker.help, { desc = "Help" })
map("n", "<leader>fm", snacks.picker.man, { desc = "Man pages" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		local desc = function(desc)
			return { buffer = buf, desc = desc }
		end

		map("n", "gd", snacks.picker.lsp_definitions, desc("Go to definition"))
		map("n", "gD", snacks.picker.lsp_declarations, desc("Go to declaration"))
		map("n", "gr", snacks.picker.lsp_references, desc("References"))
		map("n", "gi", snacks.picker.lsp_implementations, desc("Go to implementation"))
		map("n", "gt", snacks.picker.lsp_type_definitions, desc("Type definition"))
		map("n", "gs", snacks.picker.lsp_symbols, desc("Document symbols"))
		map("n", "<leader>cs", snacks.picker.lsp_symbols, desc("Document symbols"))
		map("n", "<leader>cS", snacks.picker.lsp_workspace_symbols, desc("Workspace symbols"))

		map("n", "K", function()
			vim.lsp.buf.hover({ max_width = 100, max_height = 20 })
		end, desc("Hover documentation"))
		map("i", "<C-k>", function()
			vim.lsp.buf.signature_help({ max_width = 100, max_height = 20 })
		end, desc("Signature help"))

		map("n", "<leader>rn", vim.lsp.buf.rename, desc("Rename symbol"))
		map("n", "<leader>ca", vim.lsp.buf.code_action, desc("Code actions"))

		map("n", "L", vim.diagnostic.open_float, desc("Line diagnostics"))
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, desc("Previous diagnostic"))
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, desc("Next diagnostic"))

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint", ev.buf) then
			map("n", "\\h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, desc("Toggle inlay hints"))
		end
	end,
})
