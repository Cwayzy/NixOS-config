{
  content = ''
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 12,

		border_size = 0,

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 0.85,

		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "rgba(0a0a0aee)",
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			new_optimizations = true,
			xray = true,
			vibrancy = 1,
		},

		dim_inactive = true,
		dim_strength = 0.15,
		dim_special = 0.3,
	},

	animations = {
		enabled = true,

		hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } }),
		hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } }),
		hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } }),
		hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } }),

		hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutCubic", style = "popin 90%" }),
		hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "easeOutCubic", style = "popin 90%" }),
		hl.animation({
			leaf = "windowsOut",
			enabled = true,
			speed = 2.5,
			bezier = "easeOutCubic",
			style = "popin 90%",
		}),
		hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "easeOutCubic" }),

		hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "almostLinear" }),
		hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" }),
		hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" }),
		hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2, bezier = "almostLinear" }),
		hl.animation({ leaf = "fadeShadow", enabled = true, speed = 2, bezier = "almostLinear" }),
		hl.animation({ leaf = "fadeDim", enabled = true, speed = 2, bezier = "almostLinear" }),

		hl.animation({ leaf = "layers", enabled = true, speed = 2.5, bezier = "easeOutCubic", style = "fade" }),
		hl.animation({ leaf = "layersIn", enabled = true, speed = 2.5, bezier = "easeOutCubic", style = "fade" }),
		hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "linear", style = "fade" }),

		hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" }),
		hl.animation({
			leaf = "specialWorkspace",
			enabled = true,
			speed = 3,
			bezier = "easeOutQuint",
			style = "slidevert",
		}),

		hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "linear" }),
		hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "linear" }),
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		mfact = "0.67",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})
  '';
  autoLoad = true;
}
