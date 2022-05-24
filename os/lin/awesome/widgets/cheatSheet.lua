cheatSheetWidget = wibox.widget.textbox()

cheatSheetIcon = wibox.widget.imagebox()
cheatSheetIcon:set_image(icon_path .. "articles.png")
cheatSheetIcon.visible = true

cheatSheetWidget_tooltip = awful.tooltip({ objects = { cheatSheetWidget, cheatSheetIcon },})
-- cheatSheetWidget_t = awful.tooltip({ objects = { uraicon },})

vicious.register(cheatSheetWidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local s = io.popen("cd ~/Documents && cat awesomewmshortcuts.txt")
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

        cheatSheetWidget_tooltip:set_text(str)

        return ''
    end, 9000, "Arch")
