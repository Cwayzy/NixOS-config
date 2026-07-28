{
  content = ''
-- MONITOR ALIASES --
local dell = "desc: Dell Inc. DELL U2414H"
local philips = "desc: Philips Consumer Electronics Company PHILIPS FTV"
local laptop = "desc: BOE 0x0A7C"

local hostname = io.popen("cat /etc/hostname"):read("*l")

-- MONITORS PER MACHINE--
if hostname == "C-HP" then
	hl.monitor({
		output = laptop,
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1",
	})

	hl.monitor({
		output = dell,
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1",
		mirror = laptop,
	})

	hl.monitor({
		output = philips,
		mode = "1920x1080@60",
		position = "-1920x0",
		scale = "1",
	})
	hl.monitor({
		output = "HDMI-A-1",
		mode = "preferred",
		position = "auto",
		scale = "1",
	})
else
	hl.monitor({
		output = dell,
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1",
		mirror = laptop,
	})

	hl.monitor({
		output = philips,
		mode = "1920x1080@60",
		position = "-1920x0",
		scale = "1",
	})

	hl.monitor({
		output = "",
		mode   = "1920x1080@60",
		position = "0x0",
		scale    = "1",
	})
end
  '';
  autoLoad = true;
}
