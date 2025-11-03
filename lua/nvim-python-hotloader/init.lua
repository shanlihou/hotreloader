local M = {}

-- Function to get Python context using simple parsing (fallback method)
local function get_python_context_simple()
  -- Check if current file is a Python file
  if vim.bo.filetype ~= "python" then
    vim.notify("This command only works with Python files!", vim.log.levels.ERROR)
    return
  end

  -- Get current cursor position
  local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Get filename as module name
  local modName = vim.fn.expand("%:t:r")
  local className = "Unknown"
  local funcName = "Unknown"

  -- Get all lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Find closest class and function
  local closest_class = nil
  local closest_func = nil

  for i, line in ipairs(lines) do
    if i > cursor_line then
      break
    end

    -- Find class
    local class_match = line:match("^%s*class%s+([A-Za-z_][A-Za-z0-9_]*)")
    if class_match then
      closest_class = class_match
    end

    -- Find function
    local func_match = line:match("^%s*def%s+([A-Za-z_][A-Za-z0-9_]*)")
    if func_match then
      closest_func = func_match
    end
  end

  if closest_class then
    className = closest_class
  end

  if closest_func then
    funcName = closest_func
  end

  -- Print results
  print(string.format("Python Context (simple):"))
  print(string.format("  Module: %s", modName))
  print(string.format("  Class: %s", className))
  print(string.format("  Function: %s", funcName))

  vim.notify(string.format("M:%s | C:%s | F:%s", modName, className, funcName), vim.log.levels.INFO)
end

M.setup = function(opts)
  local default_opts = {
    auto_reload = true
  }

  local config = vim.tbl_deep_extend('force', default_opts, opts or {})

  -- Register command
  vim.api.nvim_create_user_command(
    'PythonContext',
    get_python_context_simple,
    {
      desc = 'Get Python context from cursor (simple mode)'
    }
  )

  vim.notify('nvim-python-hotloader loaded!', vim.log.levels.INFO)
end

return M
