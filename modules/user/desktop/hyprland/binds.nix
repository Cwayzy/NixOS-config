{
  content = ''
-- ALIASES --
local terminal = "kitty"
local fileManager = "thunar"
local browser = "brave"
local menu = "wofi --show drun"
local capture = "hyprshot -m region --freeze --clipboard-only"
local clip = "pkill -SIGUSR1 -f gpu-screen-recorder"

local mod = "SUPER"
local hyper = "MOD3"
local sup = "SUPER + SHIFT"

-- LAPTOP SPECIFIC--
local hostname = io.popen("cat /etc/hostname"):read("*l")

if hostname == "C-HP" then
	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
		{ locked = true, repeating = true }
	)
	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
		{ locked = true, repeating = true }
	)
	hl.bind(
		"XF86AudioMute",
		hl.dsp.exec_cmd("bash $HOME/.dotfiles/modules/user/hypr-extras/scripts/toggle-mute.sh"),
		{ locked = true, repeating = true }
	)
	hl.bind(
		"XF86AudioMicMute",
		hl.dsp.exec_cmd("bash $HOME/.dotfiles/modules/user/hypr-extras/scripts/toggle-micmute.sh"),
		{ locked = true, repeating = true }
	)
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
		{ locked = true, repeating = true }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
		{ locked = true, repeating = true }
	)

	hl.bind(hyper .. " + P", hl.dsp.exec_cmd("bash $HOME/.dotfiles/modules/user/hypr-extras/scripts/toggle-hdmi.sh"))

	hl.bind("ALT + 1", hl.dsp.exec_cmd("powerprofilesctl set performance && notify-send 'Power Profile' 'Performance'"))
	hl.bind("ALT + 2", hl.dsp.exec_cmd("powerprofilesctl set balanced && notify-send 'Power Profile' 'Balanced'"))
	hl.bind("ALT + 3", hl.dsp.exec_cmd("powerprofilesctl set power-saver && notify-send 'Power Profile' 'Power Saver'"))
end

-- SYSTEM APPLICATIONS --
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + N", hl.dsp.exec_cmd(terminal .. " --class Neovim -e nvim"))
hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd(terminal .. " --class BTOP -e btop"))
hl.bind(mod .. " + A", hl.dsp.exec_cmd(terminal .. " --class aerc -e aerc"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(terminal .. " --class yazi -e yazi"))
hl.bind(hyper .. " + B", hl.dsp.exec_cmd("bash $HOME/.dotfiles/modules/user/hypr-extras/scripts/bluetooth-toggle.sh"))
hl.bind(sup .. " + S", hl.dsp.exec_cmd(capture))
hl.bind(mod .. " + S", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(hyper .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(hyper .. " + E", hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind(hyper .. " + SHIFT_R", hl.dsp.exec_cmd("steam"))
hl.bind(hyper .. " + V", hl.dsp.exec_cmd("easyeffects"))
hl.bind(mod .. " + BACKSPACE", hl.dsp.exec_cmd("hyprlock"))
hl.bind("ALT + G", hl.dsp.exec_cmd(clip))

hl.bind("Page_Down", hl.dsp.send_shortcut({ mods = "", key = "Delete" }), { repeating = true })

hl.bind(hyper .. " + comma", hl.dsp.exec_cmd("wtype '<'"))
hl.bind(hyper .. " + period", hl.dsp.exec_cmd("wtype '>'"))
hl.bind(hyper .. " + minus", hl.dsp.exec_cmd("wtype '|'"))
hl.bind(hyper .. " + return", hl.dsp.exec_cmd("virsh -c qemu:///system start win11"))

hl.bind("Delete", hl.dsp.pass({ window = "class:^(discord)$" }))
hl.bind("Page_Up", hl.dsp.pass({ window = "class:^(discord)$" }))

hl.bind(hyper .. " + ESCAPE", hl.dsp.exec_cmd("shutdown now"))
hl.bind(
	mod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
-- WORKSPACE MANIPULATION --
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(sup .. "+" .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(sup .. " + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(sup .. " + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(sup .. " + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(sup .. " + J", hl.dsp.window.swap({ direction = "down" }))

-- SPECIAL WORKSPACES --
hl.bind(mod .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(sup .. " + D", hl.dsp.window.move({ workspace = "special:discord" }))

hl.bind(mod .. " + W", hl.dsp.workspace.toggle_special("wiki"))
hl.bind(sup .. " + W", hl.dsp.window.move({ workspace = "special:wiki" }))

hl.bind(mod .. " + G", hl.dsp.workspace.toggle_special("game"))
hl.bind(sup .. " + G", hl.dsp.window.move({ workspace = "special:game" }))

-- MOUSE CONTROL --
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- WINDOW CONTROL --
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float())
hl.bind(hyper .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }, "toggle"))
hl.bind("ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }, "toggle"))

-- MEDIA --
hl.bind("code:121", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("code:122", hl.dsp.exec_cmd("playerctl previous"), { locked = true, repeating = true })
hl.bind("code:123", hl.dsp.exec_cmd("playerctl next"), { locked = true, repeating = true })
  '';
  autoLoad = true;
}
