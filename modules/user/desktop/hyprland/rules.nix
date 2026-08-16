{
  content = ''
-- MONITOR ALIASES --
local dell = "desc: Dell Inc. DELL U2414H"
local philips = "desc: Philips Consumer Electronics Company PHILIPS FTV"
local laptop = "desc: BOE 0x0A7C"

local hostname = io.popen("cat /etc/hostname"):read("*l")
local primary = hostname == "C-HP" and laptop or dell

-- WORKSPACE RULES --
for _, ws in ipairs({ 1, 3, 5, 6, 7, 8, 9, 10 }) do
	hl.workspace_rule({ workspace = tostring(ws), monitor = primary })
end

if hostname == "C-HP" then
	hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
end

hl.workspace_rule({ workspace = "1", monitor = primary, default = true })
hl.workspace_rule({ workspace = "2", monitor = philips, default = true })
hl.workspace_rule({ workspace = "4", monitor = philips })

hl.workspace_rule({
	workspace = "special:discord",
	layout = "master",
	on_created_empty = "discord & sleep 5 && pear-desktop",
})

-- APPLICATION RULES --
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({ match = { class = "^steam_app_.*$" }, workspace = "special:game silent" })

hl.window_rule({ match = { class = "hyprland-run" }, move = "20 monitor_h-120", float = true })
hl.window_rule({ match = { class = "kitty" }, opacity = "0.5 0.5" })

hl.window_rule({ match = { class = "steam" }, workspace = "3" })
hl.window_rule({ match = { class = "heroic" }, workspace = "3" })
hl.window_rule({
	match = { class = "discord" },
	workspace = "special:discord",
	opacity = "1 override",
})
hl.window_rule({ match = { class = "Spotify" }, workspace = "special:discord", opacity = "1 override" })
hl.window_rule({ match = { class = "com.github.th-ch.youtube-music" }, workspace = "special:discord", opacity = "1 override" })
  '';
  autoLoad = true;
}
