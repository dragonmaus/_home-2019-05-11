require("vis")
ec = require("editorconfig")

function vis_set(option, value)
  if type(value) == "boolean" then
    if value then
      value = "yes"
    else
      value = "no"
    end
  end

  vis:command(string.format("set %s %s", option, value))
end

OPTIONS = {
  indent_style = function(value)
    vis_set("expandtab", (value == "space"))
  end,

  indent_size = function(value)
    if value ~= "tab" then
      vis_set("tabwidth", value)
    end
  end,

  tab_width = function(value)
    vis_set("tabwidth", value)
  end,

  -- Not supported by vis:
  --  charset
  --  end_of_line
  --  insert_final_newline
  --  max_line_length
  --  trim_trailing_whitespace
}

function ec_parse(file)
  if file then
    prop, names = ec.parse(file)
    -- deterministically order editorconfig properties
    -- reverse ordering is used so that indent_size can override tab_width
    table.sort(names, function(a, b) return a > b end)
    for i, name in ipairs(names) do
      if OPTIONS[name] then
        OPTIONS[name](prop[name])
      end
    end
  end
end

vis:command_register("ec_parse", function()
  ec_parse(vis.win.filepath)
end, "(Re)parse an editorconfig file")

vis.events.subscribe(vis.events.FILE_OPEN, function(file)
  ec_parse(file.path)
end)

vis.events.subscribe(vis.events.FILE_SAVE_POST, function(file, path)
  ec_parse(path)
end)
