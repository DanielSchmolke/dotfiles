return {
  "tasks",
  -- todo can we put this in the repo and just load it from here?
  -- also, we should probably just read this stuff from the tasks.json
  dir = vim.fn.stdpath("config") .. "/lua/plugins",
  dev = true,
  -- lazy = false,

  config = function()
    local function td10_matcher(lead, args, cursor_pos)
      local parts = vim.split(args, "%s+")
      local _, type = unpack(parts)
      local arg_index = #parts - 1 -- # is length of the thing
      local types = {
        "standard",
        "slow_speed",
        "low_draft",
      }
      local control_units = {
        "KSZ6",
        "KSZ7",
      }
      local build_args = {
        "--fastbuild",
        "--fastbuild --copysim",
      }

      if arg_index == 1 then
        return types
      elseif arg_index == 2 then
        return control_units
      elseif arg_index == 3 then
        return build_args
      end
    end

    -- multi complete build command test
    vim.api.nvim_create_user_command("BuildTD10", function(opts)
      local parts = vim.split(opts.args, "%s")
      if #parts < 2 then
        print("Error: missing required arguments")
      end

      local type, control_unit, build_arg_1, build_arg_2 = unpack(parts)
      if not build_arg_1 then
        build_arg_1 = ""
      end
      if not build_arg_2 then
        build_arg_2 = ""
      end

      local command = "python scripts/build.py build --identifier TD10"
        .. "_"
        .. type
        .. "-"
        .. control_unit
        .. " "
        .. build_arg_1
        .. " "
        .. build_arg_2

      vim.keymap.set("n", "<leader>bx", ":Build " .. command, { desc = "re-execute last Build call" })
      vim.cmd("split | terminal")
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      local _ = vim.fn.jobstart(command, {
        cwd = "C:/workspace/TD8/product",
        term = true,
        on_exit = function(_, _, _) end,
      })
    end, { nargs = "*", complete = td10_matcher })

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
    vim.api.nvim_create_user_command("BuildTD10standardKSZ6", function(opts)
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
