-- CPU usage widget
cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_height(30)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color("#7070FF")
-- cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })

cpuwidget_t = awful.tooltip({ objects = { cpuwidget },})

-- Register CPU widget
vicious.register(cpuwidget, vicious.widgets.cpu,
    function (widget, args)
        cpuwidget_t:set_text("CPU Usage: " .. args[1] .. "%")
        return args[1]
    end)
