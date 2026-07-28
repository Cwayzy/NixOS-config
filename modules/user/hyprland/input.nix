{
  content = ''
-- INPUT --
hl.config({
	input = {
		kb_layout = "ee",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:hyper",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "steelseries-steelseries-rival-3-wireless",
	sensitivity = -0.5,
})

-- ENVIORMENT --
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({ xwayland = { force_zero_scaling = true } })
  '';
  autoLoad = true;
}
