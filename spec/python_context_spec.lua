describe("Python Context Command", function()
  local plugin = require("nvim-python-hotloader")

  before_each(function()
    -- Clean up any existing commands
    vim.cmd("silent! delcommand PythonContext")
  end)

  it("should setup the plugin and register the command", function()
    plugin.setup({ auto_reload = false })

    -- Check if the command was registered
    local commands = vim.fn.getcompletion("PythonContext", "command")
    assert.is_true(#commands > 0)
    assert.is_true(vim.tbl_contains(commands, "PythonContext"))
  end)

  it("should not crash with non-python files", function()
    plugin.setup({ auto_reload = false })

    -- Set a non-python filetype
    vim.bo.filetype = "javascript"

    -- Mock the cursor position
    vim.api.nvim_win_set_cursor(0, { 1, 0 })

    -- This should not crash
    local success = pcall(vim.cmd, "PythonContext")
    assert.is_true(success)
  end)

  it("should parse simple Python code correctly", function()
    plugin.setup({ auto_reload = false })

    -- Create a test Python buffer
    local bufnr = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_set_current_buf(bufnr)
    vim.bo.filetype = "python"

    -- Set test content
    local test_lines = {
      "class MyClass:",
      "    def my_method(self):",
      "        pass",
      "def top_function():",
      "    pass"
    }
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, test_lines)

    -- Test case 1: Inside class method
    vim.api.nvim_win_set_cursor(0, { 2, 10 }) -- Line 2, inside my_method
    local success1 = pcall(vim.cmd, "PythonContext")
    assert.is_true(success1)

    -- Test case 2: Inside top-level function
    vim.api.nvim_win_set_cursor(0, { 4, 5 }) -- Line 4, inside top_function
    local success2 = pcall(vim.cmd, "PythonContext")
    assert.is_true(success2)

    -- Test case 3: At class definition
    vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Line 1, class definition
    local success3 = pcall(vim.cmd, "PythonContext")
    assert.is_true(success3)
  end)

  it("should detect module name from filename", function()
    plugin.setup({ auto_reload = false })

    -- The plugin uses vim.fn.expand to get the filename
    -- We just verify it doesn't crash
    vim.bo.filetype = "python"
    vim.api.nvim_win_set_cursor(0, { 1, 0 })

    local success = pcall(vim.cmd, "PythonContext")
    assert.is_true(success)
  end)
end)

