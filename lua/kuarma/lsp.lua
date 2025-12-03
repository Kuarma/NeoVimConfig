local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "⋆",
	},

	severity_sort = true,
	update_in_insert = true,
})
