-- vim.cmd("10split")
-- local vwin = vim.api.nvim_get_current_win()
-- local buf = vim.api.nvim_create_buf(false, true)
-- vim.api.nvim_win_set_buf(vwin, buf)
--
-- vim.api.nvim_win_call(vwin, function()
-- 	vim.cmd([[put = execute('message') ]])
-- end)
--
-- local function closeMY(win, buf)
-- 	if vim.api.nvim_win_is_valid(win) then
-- 		vim.api.nvim_win_close(win, true)
-- 	end
-- 	if vim.api.nvim_buf_is_valid(buf) then
-- 		vim.api.nvim_buf_delete(buf, {})
-- 	end
-- end
--
-- vim.api.nvim_buf_set_keymap(buf, "n", "q", [[<cmd>lua closeMY()<cr>]], {
-- 	silent = true,
-- 	noremap = true,
-- 	nowait = true,
-- })

local View = require("myMessage.view")
local Message = {}

---@type nil|MessageView
local view

function Message.is_open()
	return view and view:is_valid() or false
end

function Message.open()
	if view then
		view:clear()
		view:message()
	else
		vim.cmd("10split")
		view = View:new()
		view:attach()
		view:lock()
	end
end

function Message.toggle()
	if view then
		view:unlock()
		view:close()
		view = nil
	else
		Message.open()
	end
end

return Message
