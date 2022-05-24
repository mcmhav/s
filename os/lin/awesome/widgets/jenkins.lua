jenkinswidget = wibox.widget.textbox()

jenkinswidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function ()
        local jenkinsLink = gJB()
        local buildUrl = ju .. jenkinsLink
        awful.util.spawn("chromium-browser " .. buildUrl .. ja.lb)
        awful.util.spawn("chromium-browser " .. buildUrl .. ja.f)
        awful.util.spawn("chromium-browser " .. buildUrl .. ja.ft)
    end)
))

function gJB()
    local io = { popen = io.popen }
    local domain = jDom
    local gitBranch = io.popen("cd /git/" .. domain .. "/ && git rev-parse --abbrev-ref HEAD")
    local str = ''
    local c = 0

    for line in gitBranch:lines() do
        if c > 0 then
            c = c + 1;
        else
            str = domain .. "_" .. string.lower(line):gsub("/", "_")
        end
        c = c + 1
    end

    gitBranch:close()

    return str
end

vicious.register(jenkinswidget, vicious.widgets.pkg,
    function(widget,args)
        local io = { popen = io.popen }
        local str = ''
        local url = gJB()
        local jenkinsStatus = io.popen("wget -qO- \"" .. jau .. "?tree=jobs[color,name]&xpath=/hudson/job[name='" .. url .. "']\" | xmllint -html --xpath '//job/color/text()' - 2>/dev/null")
        local c = 0
        local dot = ''

        for line2 in jenkinsStatus:lines() do
            if c > 0 then
                c = c + 1;
            else
                str = line2
            end
            c = c + 1
        end

        jenkinsStatus:close()

        if str == "blue" then
            dot = "<span color='#00DD00'>⬤</span>"
        elseif str == "blue_anime" then
            dot = "<span color='#888800'>⬤</span>"
        elseif str == "red" then
            dot = "<span color='#DD0000'>⬤</span>"
        elseif str == "red_anime" then
            dot = "<span color='#DD8800'>⬤</span>"
        elseif str == "notbuilt" then
            dot = "<span color='#DDDDDD'>⬤</span>"
        elseif str == "aborted" then
            dot = "<span color='#DDDDDD'>⬤</span>"
        elseif str == "disabled" then
            dot = "<span color='#DDDDDD'>⬤</span>"
        elseif str == "notbuilt_anime" then
            dot = "<span color='#85AD6C'>⬤</span>"
        else
            dot = "<span color='#DDDDDD'>⬤</span>"
        end

        return dot
    end, 60, "Arch")
