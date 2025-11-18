require("mason").setup()

local capabilities = {
	general = {
		positionEncodings = {
			"utf-8",
			"utf-16",
			"utf-32"
		},
	},
}

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
})
