-- RAM usage widget
memwidget = awful.widget.graph()
memwidget:set_width(50)
memwidget:set_height(30)
memwidget:set_background_color('#494B4F')
memwidget:set_color('#AECF96')
-- memwidget:set_gradient_colors({ '#AECF96', '#88A175', '#FF5656' })
-- RAM usage tooltip
memwidget_t = awful.tooltip({ objects = { memwidget },})

vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem,
    function (widget, args)
        memwidget_t:set_text(" RAM: " .. args[2] .. "MB / " .. args[3] .. "MB ")
        return args[1]
    end, 13)
--update every 13 seconds
