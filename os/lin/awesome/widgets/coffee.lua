-- Coffee Widget

coffeeWidget = wibox.widget.textbox()
coffeeIcon = wibox.widget.imagebox()
coffeeIcon:set_image(icon_path .. "coffee.png")
coffeeIcon.visible = true

coffeeGraph = awful.widget.graph()
coffeeGraph:set_width(50)
coffeeGraph:set_height(30)
coffeeGraph:set_background_color('#494B4F')
coffeeGraph:set_color('#FF5656')
coffeeGraph:set_scale(true)

coffeeWidget_tooltip = awful.tooltip({ objects = { coffeeWidget, coffeeIcon, coffeeGraph },})

coffeeIcon:buttons(awful.util.table.join(
    awful.button({ }, 1,
    function ()
        local s = io.popen("cd ~/r/s/lin-sys-setup/.scripts/coffeeCounter && ./coffeeCounter.sh --addCoffee")
        s:close()
        vicious.force({ coffeeWidget })
    end)
))

function getCoffeeCount (widget,args)
    local io = { popen = io.popen }
    local s1 = io.popen("cd ~/r/s/lin-sys-setup/.scripts/coffeeCounter && ./coffeeCounter.sh --getCount"):read()
    local s2 = io.popen("cd ~/r/s/lin-sys-setup/.scripts/coffeeCounter && ./coffeeHalfLifer.sh -hf"):read()

    coffeeWidget_tooltip:set_text(s2)

    return s1
end

function getCoffeeCountGrapher (widget,args)
    local io = { popen = io.popen }
    local s1 = io.popen("cd ~/r/s/lin-sys-setup/.scripts/coffeeCounter && ./coffeeHalfLifer.sh -hf"):read()

    coffeeGraph:add_value(tonumber(s1))

    return s1
end

vicious.register(
    coffeeWidget,
    vicious.widgets.pkg,
    getCoffeeCount,
    300,
    "Arch"
)

vicious.register(
    coffeeGraph,
    vicious.widgets.pkg,
    getCoffeeCountGrapher,
    900,
    "Arch"
)
