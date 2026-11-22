local augroup = vim.api.nvim_create_augroup("A4eiron", { clear = true })

local treesitter_group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		if not vim.treesitter.highlighter.active[ev.buf] then
			vim.treesitter.start(ev.buf, lang)
		end

		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	group = augroup,
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd("TSUpdate")
		end
	end,
})
