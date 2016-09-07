-- Weather Widget
-- weatherwidget = wibox.widget.textbox()
-- weathericon = wibox.widget.imagebox()
-- weathericon:set_image(icon_path .. "articles.png")
-- weatherimg = wibox.widget.imagebox()
-- weathericon.visible = true

-- weatherwidget_tn = awful.tooltip({ objects = { weatherwidget},})
-- weatherwidget_t = awful.tooltip({ objects = { weathericon},})


-- vicious.register(weatherwidget, vicious.widgets.pkg,
--     function(widget,args)
--         local io = { popen = io.popen }
--         io.popen("cd " .. icon_path .. " && wget http://www.yr.no/sted/Norge/postnummer/7042/meteogram.png")
--         local weatherImagepath = icon_path .. "metrogram.png"
--         weatherimg:set_image(weatherImagepath)
--         weatherwidget_t:add_to_object(weatherimg)
--         weatherwidget_tn:add_to_object(weatherimg)
--         return "weather"
--         end, 3600, "Arch")

--         weatherwidget:add_signal('mouse::enter', function ()
--         weatherwidget_tn:set_text("asdf")
--         weatherwidget_t:set_text("asdf")
--         return "asdf"
--     end)
