local View = require("mess.view")
local Message = {}

---@type nil|MessageView
local view

function Message.setup()
	vim.api.nvim_create_user_command("Mess", function()
		Message.toggle()
	end, {})

	vim.api.nvim_create_user_command("MessShow", function()
		Message.show()
	end, {})
end

function Message.is_open()
	return view and view:is_valid() or false
end

function Message.open()
	vim.cmd("10split")
	view = View.new()
	view:attach()
	view:message()
	view:lock()
end

function Message.show()
	if view then
		-- "Message is already open"
		view:unlock()
		view:clear()
		view:message()
		view:focus()
		view:lock()
	else
		-- "Message is not open"
		Message.open()
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

function Message.close()
	if Message.is_open() and view then
		view:close()
		view = nil
	end
end

return Message
