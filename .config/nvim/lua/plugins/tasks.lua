return {
  "tasks",
  -- todo can we put this in the repo and just load it from here?
  dir = vim.fn.stdpath("config") .. "/lua/plugins",
  dev = true,
  -- lazy = false,

  config = function()
    local function multiline(lead, args)
      local parts = vim.split(args, "%s+")
      local _, machine, type, build_arg_1 = unpack(parts)
      local arg_index = #parts - 1 -- # is length of the thing
      -- local machines = { "TD9", "TD10" }
      local machines = { "TD10" }
      local types = {
        TD10 = { "standard", "low_draft", "slow_speed" },
        -- TD9 = { "double", "single" },
      }
      local build_args = {
        "--fastbuild",
        "--copysim",
      }

      if arg_index == 1 then
        return vim.tbl_filter(function(item)
          return item:find("^" .. machine)
        end, machines)
      elseif arg_index == 2 then
        return vim.tbl_filter(function(item)
          return item:find("^" .. type)
        end, types[machine])
      elseif arg_index == 3 then
        return vim.tbl_filter(function(item)
          return item:find("^" .. lead)
        end, build_args)
      elseif arg_index == 4 then
        local item = {}
        if build_arg_1 == build_args[1] then
          item[1] = build_args[2]
        else
          item[1] = build_args[1]
        end
        return item
      end
    end

    -- multi complete build command test
    vim.api.nvim_create_user_command("Build", function(opts)
      local parts = vim.split(opts.args, "%s")
      if #parts < 2 then
        print("Error: missing required arguments")
      end

      local machine, type, build_arg_1, build_arg_2 = unpack(parts)
      local command = "python scripts/build.py build --identifier "
        .. machine
        .. "_"
        .. type
        .. " "
        .. build_arg_1
        .. " "
        .. build_arg_2

      vim.cmd("split | terminal")
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      local _ = vim.fn.jobstart(command, {
        -- cwd = "C:/workspace/TD8/product",
        term = true,
        on_exit = function(_, code, _)
          if code == 0 then
            vim.keymap.set("n", "<leader>bx", ":Build " .. command, { desc = "re-execute last Build call" })
          else
            print("Job exited with code: " .. code)
          end
        end,
      })
    end, { nargs = "*", complete = multiline })

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
