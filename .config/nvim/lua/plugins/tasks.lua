return {
  "tasks",
  -- todo can we put this in the repo and just load it from here?
  dir = vim.fn.stdpath("config") .. "/lua/plugins",
  dev = true,
  -- lazy = false,

  config = function()
    -- KSZ7
    vim.api.nvim_create_user_command("BuildTD10standardKSZ7", function()
      vim.cmd("split | terminal")
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      local _ = vim.fn.jobstart("python scripts/build.py build --identifier TD10_standard-KSZ7 --fastbuild --local", {
        cwd = "C:/workspace/TD8/product",
        term = true,
        on_exit = function(_, code, _)
          print("Job exited with code: " .. code)
        end,
      })
    end, {})

    -- KSZ6
    vim.api.nvim_create_user_command("BuildTD10standardKSZ6", function()
      vim.cmd("split | terminal")
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      local _ = vim.fn.jobstart("python scripts/build.py build --identifier TD10_standard-KSZ6 --fastbuild --local", {
        cwd = "C:/workspace/TD8/product",
        term = true,
        on_exit = function(_, code, _)
          print("Job exited with code: " .. code)
        end,
      })
    end, {})
  end,
}
