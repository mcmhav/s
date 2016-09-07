-- Network widget
netwidget_text = wibox.widget.textbox()
vicious.register(netwidget_text, vicious.widgets.net,
    function (widget, args)
        if args["{enp5s0 carrier}"] == 1 then
            return '<span color="#CC9393">' .. args["{enp5s0 down_kb}"] .. '</span> <span color="#7F9F7F">' .. args["{enp5s0 up_kb}"] .. '</span>'
        elseif args["{wlp3s0 carrier}"] == 1 then
            return '<span color="#CC9393">' .. args["{wlp3s0 down_kb}"] .. '</span> <span color="#7F9F7F">' .. args["{wlp3s0 up_kb}"] .. '</span>'
        else
            return 'Network Disabled'
        end
    end, 3)

netwidget = awful.widget.graph()
netwidget:set_width(50)
netwidget:set_height(30)
netwidget:set_background_color("#494B4F")
netwidget:set_color("#FF5656")
netwidget:set_scale(true)
-- netwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
netwidget_t = awful.tooltip({ objects = { netwidget },})

-- Register network widget
-- find entrypoint with ifconfig, select the ones to use
vicious.register(netwidget, vicious.widgets.net,
    function (widget, args)
        if args["{eth0 carrier}"] == 1 then
            netwidget_t:set_text("Down: " .. args["{eth0 down_kb}"] .. "kb/s" .. "\nUp: " .. args["{eth0 up_kb}"] .. "kb/s" )
            return args["{eth0 down_kb}"]
        elseif args["{wlp3s0 carrier}"] == 1 then
            netwidget_t:set_text("Down: " .. args["{wlp3s0 down_kb}"] .. "kb/s" .. "\nUp: " .. args["{wlp3s0 up_kb}"] .. "kb/s" )
            return args["{wlp3s0 down_kb}"]
        else
            return 'Network Disabled'
        end
    end, 1)
