vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/j-hui/fidget.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("fidget").setup()

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				hint = { enable = true },
				diagnostics = { globals = { "vim" } },
			},
		},
	},
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
					unreachable = true,
				},

				staticcheck = true,
				gofumpt = true,
				completeUnimported = true,
			},
		},
	},
	rust_analyzer = {},
	clangd = {},
	basedpyright = {},

	ts_ls = {
		root_markers = { "package.json" },
		single_file_support = true,
	},
	denols = {
		root_markers = { "deno.json", "deno.jsonc" },
		single_file_support = false,
	},
}

local ensure_installed = vim.tbl_keys(servers or {})

vim.list_extend(ensure_installed, {
	"stylua",
	"prettierd",
	"black",
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local lsp_map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		lsp_map("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, "Go to definition")
		lsp_map("n", "gD", function()
			Snacks.picker.lsp_declarations()
		end, "Go to definition")
		lsp_map("n", "gr", function()
			Snacks.picker.lsp_references()
		end, "Go to references")
		lsp_map("n", "<leader>ss", function()
			Snacks.picker.lsp_symbols()
		end, "LSP symbols")
		lsp_map("n", "K", function()
			vim.lsp.buf.hover({ max_height = 40, max_width = 100 })
		end, "Hover doc")
		lsp_map("n", "grn", vim.lsp.buf.rename, "Rename")
		lsp_map("n", "gra", vim.lsp.buf.code_action, "Code action")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			lsp_map("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
		end

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
			end,
		})
	end,
})
