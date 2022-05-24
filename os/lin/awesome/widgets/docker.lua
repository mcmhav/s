dockerwidget = wibox.widget.textbox()
dockericon = wibox.widget.imagebox()
dockericon:set_image(icon_path .. "docker.png")
dockericon.visible = true

vicious.register(dockerwidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("docker ps | wc -l")
        local str = ''
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

        -- workwidget_tn:set_text('')
        -- workwidget_t:set_text('')

        return str
    end, 900, "Arch")
