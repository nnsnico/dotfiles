--@see .yabairc

local stackline = require("stackline")

local stackline_config = {
  paths = {
    yabai = '/opt/homebrew/bin/yabai' -- for monterey
  }
}

stackline:init(stackline_config)
stackline.config:set('appearance.offset.x', 8)
