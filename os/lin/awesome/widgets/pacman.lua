-- Pacman Widget
pacwidget = wibox.widget.textbox()
pkgicon = wibox.widget.imagebox()
pkgicon:set_image(icon_path .. "pacman.png")
pkgicon.visible = false

pacwidget_tn = awful.tooltip({ objects = { pacwidget},})
pacwidget_t = awful.tooltip({ objects = { pkgicon},})

vicious.register(pacwidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("pacman -Qu")
        local str = ''
        local ystr = ''
        local c = 0

        for line in s:lines() do
            if c > 0 then
                str = str .. "\n" .. line
            else
                str = str .. line
            end
            c = c + 1
        end

        s:close()

        pacwidget_tn:set_text(str)
        pacwidget_t:set_text(str)

        count = ''
        args[1] = args[1] - 1
        if args[1] == 0 then
            count = 0
            else
                count = "<span color='#00AA00'>" .. args[1] .. "</span>"
            end
        return count

    end, 900, "Arch")
