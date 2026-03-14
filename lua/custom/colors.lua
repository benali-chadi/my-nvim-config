vim.opt.background = "dark"
vim.opt.cursorline = true

vim.api.nvim_set_hl(0, 'LineNrAbove', {
	fg = '#5C6773',
})

vim.api.nvim_set_hl(0, 'LineNr', {
	fg = '#59C2FF',
	bold = true
})

vim.api.nvim_set_hl(0, 'LineNrBelow', {
	fg = '#5C6773',
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = "#FFB454",
	bold = true,
})
