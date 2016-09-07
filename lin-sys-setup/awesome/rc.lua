package.path = package.path .. ";~/?.lua"
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
wibox = require("wibox")
beautiful = require("beautiful")
menubar = require("menubar")
require("errorhandlers")
beautiful.init("~/r/s/lin-sys-setup/awesome/theme.lua")
require("global")
require("tags")
-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}
vicious = require("vicious")

channel = "Master"
function volume (mode, widget)
if mode == "up" then
    io.popen("amixer set " .. channel .. " 5%+"):read("*all")
    vicious.force({ widget })
elseif mode == "down" then
    io.popen("amixer set " .. channel .. " 5%-"):read("*all")
    vicious.force({ widget })
else
    io.popen("amixer set Master toggle"):read("*all")
    vicious.force({ widget })
end
end

io.popen("amixer set " .. channel .. " 40%")
require("menu")
require("widgets")

require("keybindings")

require("signals")

require("sswitch")

-- awful.util.spawn_with_shell("sh ~/repos/s/lin-sys-setup/.cakeInit.sh s")
