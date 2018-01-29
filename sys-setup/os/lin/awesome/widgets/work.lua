-- Work Widget

workwidget = wibox.widget.textbox()
workwidget_tn = awful.tooltip({ objects = { workwidget},})

vicious.register(workwidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("cd " .. nsaHome .. "r/s/lin-sys-setup/.scripts/timeLogging/ && ./findStartEnd.sh -ftl")
        local s2 = io.popen("cd " .. nsaHome .. "r/s/lin-sys-setup/.scripts/timeLogging/ && ./findStartEnd.sh -v -ws")
        local str = ''
        local str2 = ''
        local c = 0
        local c2 = 0
        local amount = 0

        for line in s:lines() do
            if c > 0 then
                str = str .. "\n" .. line
            else
                amount = tonumber(line)
                str = str .. line
            end
            c = c + 1
        end

        for line in s2:lines() do
            if c2 > 0 then
                str2 = str2 .. "\n" .. line
            else
                str2 = str2 .. line
            end
            c2 = c2 + 1
        end

        s:close()
        s2:close()

        if amount > 0 then
            str = "<span color='#00DD00'>" .. str .. "</span>"
        else
            str = "<span color='#DD0000'>" .. str .. "</span>"
        end

        workwidget_tn:set_text(str2)

        return str
    end, 300, "Arch")
