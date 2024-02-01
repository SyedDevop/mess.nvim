local name = vim.api.nvim_create_namespace("Mess-ui")
local hint_text = "[1/5]"
local virt_text = { { hint_text, "DiagnosticVirtualTextHint" } }
vim.api.nvim_buf_set_extmark(0, name, 22, -1, {
	virt_text = virt_text,
	virt_text_pos = "eol", -- Positions the virtual text at the end of the line
	hl_mode = "combine",
})
