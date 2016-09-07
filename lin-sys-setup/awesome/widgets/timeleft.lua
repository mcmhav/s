-- TimeToDate Widget
timeLeftwidget = wibox.widget.textbox()
timeicon = wibox.widget.imagebox()
timeicon:set_image(icon_path .. "time.png")
timeicon.visible = true

timeLeftwidget_tn = awful.tooltip({ objects = { timeLeftwidget},})
timewidget_t = awful.tooltip({ objects = { timeicon},})

vicious.register(timeLeftwidget, vicious.widgets.pkg,
    function(widget,args)
        local timeEnd = 1402531199
        local tfIS = math.floor((timeEnd - os.time()))
        local timeLeft = 0

        timeLeftwidget_tn:set_text(os.date("%d-%m-%Y", timeEnd))
        timewidget_t:set_text(os.date("%d-%m-%Y", timeEnd))

        if (tfIS/(60*60*24)) > 3 then
            timeLeft = math.floor(tfIS/(60*60*24))
            timeColor = toHex(255 - timeLeft)
            return " <span color='#" .. timeColor .. "0000'>" .. timeLeft .. "</span>"
        elseif (tfIS/(60*60)) > 24 then
            timeLeft = math.floor(tfIS/(60*60))
        else
            timeLeft = math.floor(tfIS/(60))
        end

        function toHex(num)
            local hexstr = '0123456789abcdef'
            local s = ''
            while num > 0 do
                local mod = math.fmod(num, 16)
                s = string.sub(hexstr, mod+1, mod+1) .. s
                num = math.floor(num / 16)
            end
            if s == '' then s = '0' end
            return s
        end

        return " <span color='#FF0000'>" .. timeLeft .. "</span>"
    end, 300, "Arch")
