---@class MessageView
---@field buf number
---@field win number
local View = {}
View.__index = View

---@return MessageView
function View:new()
	self.buf = vim.api.nvim_create_buf(false, true)
	self.win = vim.api.nvim_get_current_win()
	return self
end

function View:attach()
	vim.api.nvim_win_set_buf(self.win, self.buf)

	vim.api.nvim_buf_set_keymap(self.buf, "n", "q", [[<cmd>lua require('mess').close()<cr>]], {
		silent = true,
		noremap = true,
		nowait = true,
	})
end

function View:message()
	vim.api.nvim_win_call(self.win, function()
		vim.cmd([[put = execute('message') ]])
	end)
end

function View:set_option(name, value, win)
	if win then
		return vim.api.nvim_set_option_value(name, value, { win = self.win, scope = "local" })
	else
		return vim.api.nvim_set_option_value(name, value, { buf = self.buf })
	end
end
function View:close()
	if vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_close(self.win, true)
	end
	if vim.api.nvim_buf_is_valid(self.buf) then
		vim.api.nvim_buf_delete(self.buf, {})
	end
end
function View:is_valid()
	return vim.api.nvim_buf_is_valid(self.buf) and vim.api.nvim_buf_is_loaded(self.buf)
end

function View:clear()
	return vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, {})
end

function View:unlock()
	self:set_option("modifiable", true)
	self:set_option("readonly", false)
end

function View:lock()
	self:set_option("readonly", true)
	self:set_option("modifiable", false)
end
return View
