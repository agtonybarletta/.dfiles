local M = {}

-- Default configuration
M.config = {
  width = 0.8,   -- 80% of editor width
  height = 0.8,  -- 80% of editor height
  border = "rounded",
  title = " Float Buffer ",
}

--- Calculate window dimensions based on editor size
local function get_win_opts(opts)
  local width  = math.floor(vim.o.columns * opts.width)
  local height = math.floor(vim.o.lines * opts.height)
  local row    = math.floor((vim.o.lines - height) / 2)
  local col    = math.floor((vim.o.columns - width) / 2)

  return {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = opts.border,
    title    = opts.title,
    title_pos = "center",
  }
end

--- Expand vim variables inside a shell command string
local function expand_vim_vars(str)
  -- expand @x registers → e.g. @" becomes the unnamed register content
  str = str:gsub("@(.)", function(reg)
    return vim.fn.getreg(reg)
  end)
  -- expand % → current filename
  str = str:gsub("%%([^ ]*)", function(mod)
    return vim.fn.expand("%" .. mod)
  end)
  return str
end

--- Parse a FloatRun argument string, respecting \' escapes
--- Returns: shell_cmd, vim_template
local function parse_floatrun_args(args)
  if args:sub(1, 1) ~= "[" then
    return args, nil
  end

  -- Scan char by char, honouring \' as an escaped quote
  local i = 2
  while i <= #args do
    if args:sub(i, i) == "\\" and args:sub(i + 1, i + 1) == "]" then
      i = i + 2 -- skip escaped quote
    elseif args:sub(i, i) == "]" then
      break     -- found the real closing quote
    else
      i = i + 1
    end
  end

  local shell_cmd    = args:sub(2, i - 1):gsub("\\]", "]") -- unescape \' → '
  shell_cmd = expand_vim_vars(shell_cmd)
  local vim_template = vim.trim(args:sub(i + 1))

  return shell_cmd, vim_template ~= "" and vim_template or nil
end


--- Open a buffer in a floating window
--- @param bufnr number|nil Buffer number to display (defaults to current buffer)
--- @param opts table|nil Override default config options
function M.open(bufnr, opts)

  opts = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Use provided buffer or create a new scratch buffer
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local win_opts = get_win_opts(opts)
  local win = vim.api.nvim_open_win(bufnr, true, win_opts)

  -- Apply window-local options
  vim.wo[win].cursorline = true
  vim.wo[win].wrap = false

  -- Close the float with <Esc> or `q`
  for _, key in ipairs({ "<Esc>", "q" }) do
    vim.keymap.set("n", key, function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, { buffer = bufnr, nowait = true, silent = true })
  end

  return win, bufnr

end

--- Open a terminal in a floating window
--- @param cmd string|nil Shell command to run (defaults to $SHELL)
--- @param opts table|nil
function M.open_term(cmd, opts)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win = M.open(bufnr, opts)

  cmd = cmd or vim.o.shell
  vim.fn.termopen(cmd, {
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end,
  })

  vim.cmd("startinsert")
  return win, bufnr
end

--- Run an interactive shell command in a float and capture its output
--- @param shell_cmd string  Shell command to run (fzf, gum, etc.)
--- @param vim_template string|nil  Vim command to run after, use {} as placeholder for output
---                                 e.g. "e {}" or "vsplit {}"
--- @param opts table|nil
function M.run(shell_cmd, vim_template, opts)
  local tmp = vim.fn.tempname()

  vim.fn.writefile({}, tmp)

  local script  = vim.fn.tempname() .. ".sh"
  vim.fn.writefile({
    "#!/bin/bash",
    "bash << 'FLOATRUN_EOF' > " .. tmp,
    shell_cmd,
    "FLOATRUN_EOF"
  }, script)
  vim.fn.system("chmod +x " .. script)

  vim.fn.writefile(vim.fn.readfile(script), "/tmp/floatrun-debug.txt")


  -- local wrapped = script ..
  local wrapped = script .. " 2>/tmp/floatrun-err.txt"


  local bufnr = vim.api.nvim_create_buf(false, true)
  local win = M.open(bufnr, opts)

  vim.fn.termopen(wrapped, {
    on_exit = function()
      -- Close the float
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end

      -- Read captured output
      local lines = vim.fn.readfile(tmp)
      vim.fn.delete(tmp)
      vim.fn.delete(script)

      if not vim_template or #lines == 0 then return end

      -- Trim whitespace and substitute {} with the result
      local result = vim.trim(table.concat(lines, "\n"))
      if result == "" then return end

      local vim_cmd = vim_template:gsub("{}", result)

      -- Schedule so we're back in the main loop before running the command
      vim.schedule(function()
        vim.cmd(vim_cmd)
      end)
    end,
  })

  vim.cmd("startinsert")
  return win, bufnr
end

--- Setup function to override defaults and register a user command
--- @param user_opts table|nil
function M.setup(user_opts)
  M.config = vim.tbl_deep_extend("force", M.config, user_opts or {})

  -- :FloatBuf [bufnr]  — opens a buffer in the float
  vim.api.nvim_create_user_command("FloatBuf", function(cmd_opts)
    local bufnr = tonumber(cmd_opts.args) or nil
    M.open(bufnr)
  end, {
    nargs = "?",
    desc  = "Open a buffer in a floating window",
  })
  vim.api.nvim_create_user_command("FloatTerm", function(cmd_opts)
    local cmd = cmd_opts.args ~= "" and cmd_opts.args or nil
    M.open_term(cmd)
  end, { nargs = "?", desc = "Open terminal in float" })


  -- :FloatRun 'shell cmd' [vim template]
  vim.api.nvim_create_user_command("FloatRun", function(cmd_opts)
    local shell_cmd, vim_template
  
    -- If no args provided, use selected text from @" register
    if cmd_opts.args == "" then
      shell_cmd = vim.fn.getreg('"')
      vim_template = nil
    else
      shell_cmd, vim_template = parse_floatrun_args(cmd_opts.args)
    end

    if not shell_cmd or shell_cmd == "" then
      vim.notify("FloatRun: no command provided", vim.log.levels.ERROR)
      return
    end

    M.run(shell_cmd, vim_template)
  end, { nargs = "*", desc = "Run interactive command in float, pass output to vim cmd" })
end

M._parse_test = function(args)
  return parse_floatrun_args(args)
end

return M
