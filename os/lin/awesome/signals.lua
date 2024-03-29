-- {{{ Rules
awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons
        }
    },
-- { rule = { class = "Gimp" },
--     properties = {
--         floating = true,
--         tag = tags[screen.count()][3],
--         switchtotag=true
--     } },
-- { rule = { class = "Google-chrome" },
--     properties = {
--         tag = tags[screen.count()][1],
--         switchtotag=true
--     } },
-- { rule_any = { class = { "Nemo", "Spacefm"} },
--     properties = {
--         tag = tags[screen.count()][2],
--         switchtotag=true
--     } },
-- { rule = { class = "Syncdrive" },
--     properties = {
--         tag = tags[1][5],
--         switchtotag=false
--     } },
-- { rule = { class = "XTerm" },
--     properties = {
--         tag = tags[1][9],
--         switchtotag=true,
--         callback = awful.client.setslave
--     } },
-- { rule_any = { class = { "sublime-text", "Subl3"} },
--     properties = {
--         tag = tags[screen.count()][1],
--         switchtotag = true,
--         callback = awful.client.setslave
--     },
-- },
}
-- awful.tag.incmwfact(0.06, tags[screen.count()][1])


awful.tag.viewonly(tags[1][1])
awful.tag.incmwfact(0.36, tags[1][1])

awful.tag.incnmaster(1, tags[1][2])
awful.tag.incmwfact(0.22, tags[1][2])


awful.tag.incmwfact(0.25, tags[screen.count()][1])

awful.tag.incmwfact(0.19, tags[screen.count()][4])


-- awful.tag.viewonly(tags[][9])
-- awful.tag.incmwfact(0.45, tags[screen.count()][9])


-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)


    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
            awful.button({ }, 1, function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
            end)
        )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
