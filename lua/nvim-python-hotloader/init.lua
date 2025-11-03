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
  print()

  vim.notify(string.format("M:%s | C:%s | F:%s", modName, className, funcName), vim.log.levels.INFO)

  -- Prompt user to select a component
  print("Select a component to execute:")
  print("  1. cellapp")
  print("  2. baseapp")
  print("  3. Cancel")
  print()

  -- Get user input
  local choice = vim.fn.input("Enter your choice (1-3): ")

  -- Handle user selection
  if choice == "1" or choice == "2" then
    -- Determine component name
    local component_name = ""
    if choice == "1" then
      component_name = "cellapp"
      print(string.format("Executing cellapp for: %s.%s.%s", modName, className, funcName))
      vim.notify("Cellapp execution triggered", vim.log.levels.INFO)
    else
      component_name = "baseapp"
      print(string.format("Executing baseapp for: %s.%s.%s", modName, className, funcName))
      vim.notify("Baseapp execution triggered", vim.log.levels.INFO)
    end

    -- Find assets parent directory from current file path
    local current_file_path = vim.fn.expand("%:p")
    local assets_path = nil

    -- Split path by directory separator and search for 'assets'
    -- Handle both Unix and Windows path separators
    for directory in current_file_path:gmatch("[^\\/]+") do
      if directory == "assets" then
        -- Found assets, construct the full path up to assets
        -- We need to reconstruct the path up to and including assets
        local parts = {}
        for part in current_file_path:gmatch("[^\\/]+") do
          table.insert(parts, part)
          if part == "assets" then
            break
          end
        end

        -- Reconstruct path with proper separators
        if #parts > 0 then
          if current_file_path:find("\\") then
            -- Windows path
            assets_path = table.concat(parts, "\\")
          else
            -- Unix path
            assets_path = "/" .. table.concat(parts, "/")
          end
        end
        break
      end
    end

    if not assets_path then
      print("Error: Could not find 'assets' parent directory in file path")
      vim.notify("Assets directory not found", vim.log.levels.ERROR)
      return
    end

    -- Construct bat file path
    local bat_file_path = assets_path .. "/hotReload/genhotfix.bat"

    -- Replace forward slashes with backslashes for Windows
    bat_file_path = bat_file_path:gsub("/", "\\")

    -- Construct the full command
    local full_command = string.format('"%s" %s %s %s %s',
      bat_file_path,
      component_name,
      modName,
      className,
      funcName
    )

    -- Print the complete command before execution
    print()
    print("Executing command:")
    print(full_command)
    print()

    -- Execute the command
    local execute_result = vim.fn.system(full_command)

    -- Check if execution was successful
    if vim.v.shell_error == 0 then
      print("Command executed successfully!")
      print(execute_result)
      vim.notify("Command executed successfully", vim.log.levels.INFO)
    else
      print("Error executing command:")
      print(execute_result)
      vim.notify("Command execution failed", vim.log.levels.ERROR)
    end

  elseif choice == "3" then
    print("Operation cancelled")
    vim.notify("Operation cancelled", vim.log.levels.WARN)
  else
    print("Invalid choice. Please enter 1, 2, or 3.")
    vim.notify("Invalid choice selected", vim.log.levels.ERROR)
  end
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
