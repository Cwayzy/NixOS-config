{
  # Modules-left
  "hyprland/workspaces" = {
    format = "{name}";
    format-icons = {
      active = "";
      default = "";
    };
  };

  "cpu" = {
    interval = 1;
    format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
    format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    on-click = "btop";
  };

  "memory" = {
    interval = 1;
    format = "  {used:0.1f}G/{total:0.1f}G";
    tooltip-format = "Memory";
  };

  # Modules-center
  "clock" = {
    tooltip = false;
    format = "{:%H:%M:%S}";
    interval = 1;
  };

  # Modules-right
  "mpris" = {
    interval = 1;
    player-icons = {
      default = "";
    };
    status-icons = {
      playing = "";
      paused = "";
    };
    format = "{status_icon}  {title} - {artist} {position}/{length}" ;
		format-paused = "{status_icon}  {title} - {artist} {position}/{length}";
		on-click = "playerctl play-pause";
	  on-click-right =  "playerctl next";
		on-click-middle = "playerctl previous";
  };

  "bluetooth" = {
    format = "󰂲";
    format-on = "{icon}";
    format-off = "{icon}";
    format-connected = "{icon}";
    format-icons = {
      on = "󰂯";
      off = "󰂲";
      connected = "󰂱";
    };
    on-click = "blueman-manager";
    tooltip-format-connected = "device_enumerate";
  };

  "network" = {
    interval = 5;
    format-wifi = "󰖩";
		format-ethernet = "󰈀";
		format-disconnected = "󱛅";
    tooltip-format = "{ipaddr}";
		tooltip-format-wifi = "{essid} ({signalStrenght}%)\n{ipaddr}";
		on-click = "nm-connection-editor";
  };

  "wireplumber" = {
    format = "{icon}  {volume}%";
		format-muted = "";
		format-icons = {
			default = ["" "󰖀" ""];
		};
		on-click = "pwvucontrol";
  };

  "battery" = {
    interval = 2;
    states = {
      warning = "30";
      critical = "15";
    };
    format = "{icon}  {capacity}%";
    format-full = "{icon}  {capacity}%";
    format-charging = "󱐋 {capacity}%";
    format-plugged = " {capacity}%";
    format-icons = ["" "" "" "" ""];
    tooltip-format = "{time}\n{power}";
  };
}
