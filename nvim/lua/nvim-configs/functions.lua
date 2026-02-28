local functions = {}

function functions.MdPreview()
	vim.cmd("!pandoc % -o /tmp/tmp.pdf")
	vim.cmd("!chromium /tmp/tmp.pdf")
end

return functions
