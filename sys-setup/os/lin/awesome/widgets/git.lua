-- GitWidget Widget
gitwidget = wibox.widget.textbox()
giticon = wibox.widget.imagebox()
giticon:set_image(icon_path .. "Git-Icon-White.png")
giticon.visible = true

gitwidget_tn = awful.tooltip({ objects = { gitwidget},})
gitwidget_t = awful.tooltip({ objects = { giticon},})

vicious.register(gitwidget, vicious.widgets.pkg,
    function(widget,args)
        function checkGitStatus(repo)
            local io = { popen = io.popen }
            local location = "cd " .. repo .. "/ && "
            local s = io.popen(location .. "git log HEAD..origin/$(git rev-parse --abbrev-ref HEAD) --oneline")
            local uc = io.popen(location .. "git status -s | wc -l"):read()
            local up = io.popen(location .. "git cherry --abbrev=7 -v @{u} | wc -l"):read()

            if up == "0" then
                up = 0
            else
                up = "<span color='#ACD62A'>" .. up .. "</span>"
            end

            local str = repo .. "\n"
            local bc = 0

            for line in s:lines() do
                if bc > 0 then
                    str = str .. "\n" .. line
                else
                    str = str .. line
                end
                bc = bc + 1
            end

            if bc > 0 then
                bc = "<span color='#DD0000'>" .. bc .. "</span>"
            end
            if not (uc == '0') then
                uc = "<span color='#FF8400'>" .. uc .. "</span>"
            end
            s:close()
            return bc,str,uc,up
        end

        local bss = ''
        local cc = ''
        local c = 0

        for _,v in pairs(repos) do
            local bc,bs,uc,up = checkGitStatus(v)
            if c > 0 then
                bss = bss .. "\n" .. bs
            else
                bss = bss .. bs
            end
            cc = cc .. " " .. bc .. "(" .. uc .. ":" .. up .. ")"
            c = c + 1
        end

        gitwidget_tn:set_text(bss)
        gitwidget_t:set_text(bss)

        return " " .. cc
    end, 900, "Arch")
