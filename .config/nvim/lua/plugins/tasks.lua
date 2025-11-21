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
      local machines = { "TD9", "TD10" }
      local types = {
        TD10 = { "standard", "LowDraft", "SlowSpeed" },
        TD9 = { "double", "single" },
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
      local machine, type, build_arg_1, build_arg_2 = unpack(vim.split(opts.args, "%s"))
      -- if not build_arg_1 then build_arg_1  = "" end
      -- if not build_arg_2 then build_arg_2 = "" end
      print("Args: " .. opts.args)
      print(
        "machine: " .. machine .. " type: " .. type .. " build_arg_1: " .. build_arg_1 .. "build_arg_2: " .. build_arg_2
      )
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
