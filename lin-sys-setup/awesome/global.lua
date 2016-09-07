terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "subl"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
repos = { "/git/pm-kort", "/git/lo-kort", "/home/vagrant/r/s" }
icon_path = awful.util.getdir("config").."/img/"
