local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()

if cmp_ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

capabilities.offsetEncoding = {
	"utf-16",
	"utf-8",
	"utf-32",
}

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
