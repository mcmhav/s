-- UnreadArticlesWidget Widget
-- urawidget = wibox.widget.textbox()
-- uraicon = wibox.widget.imagebox()
-- uraicon:set_image(icon_path .. "articles.png")
-- uraicon.visible = true

-- urawidget_tn = awful.tooltip({ objects = { urawidget},})
-- urawidget_t = awful.tooltip({ objects = { uraicon},})

-- vicious.register(urawidget, vicious.widgets.pkg,
--     function(widget,args)
--         local io = { popen = io.popen }
--         local s = io.popen("cd '/home/m/gdrive/S/spring14/Master Thesis/M-Master/A' && find . -maxdepth 1 -type f")
--         local str = ""
--         local c = 0

--         for line in s:lines() do
--             if c > 0 then
--                 str = str .. "\n" .. line
--             else
--                 str = str .. line
--             end
--             c = c + 1
--         end

--         s:close()

--         urawidget_tn:set_text(str)
--         urawidget_t:set_text(str)
--         return c
--     end, 4200, "Arch")


urawidget = wibox.widget.textbox()
uraicon = wibox.widget.imagebox()
uraicon:set_image(icon_path .. "todoLogo.png")
uraicon.visible = true

urawidget_tn = awful.tooltip({ objects = { urawidget},})
urawidget_t = awful.tooltip({ objects = { uraicon},})

vicious.register(urawidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("cd '/home/m/repos/muchBazar/src' && ./getTODO.sh")
        local str = ""
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
        urawidget_tn:set_text(str)
        urawidget_t:set_text(str)

        return c - 1
    end, 300, "Arch")
