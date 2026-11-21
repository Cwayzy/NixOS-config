''
* {
  font-family: 'SF Pro Text', 'Inter', 'Segoe UI, NotoSans Nerd Font', sans-serif;
  font-size: 13px;
  font-weight: 500;
  min-height: 0;
  border: none;
  border-radius: 0;
  box-shadow: none;
}

/* --- Bar --- */
window#waybar {
  background-color: @base00;
  color: @base05;
  border-bottom: 1px solid @base02;
}

/* --- All modules: no backgrounds, just text --- */
#workspaces,
#cpu,
#memory,
#clock,
#mpris,
#bluetooth,
#network,
#wireplumber,
#battery {
  background: transparent;
  color: @base05;
  padding: 0 10px;
  margin: 0;
  transition: color 0.15s ease-in-out;
}

/* --- Workspaces --- */
#workspaces {
  padding: 0 4px;
  margin-left: 6px;
}

#workspaces button {
  color: @base04;
  background: transparent;
  padding: 0 8px;
  margin: 0;
  border-bottom: 2px solid transparent;
  transition: color 0.15s ease-in-out, border-color 0.15s ease-in-out;
}

#workspaces button:hover {
  background: transparent;
  color: @base07;
}

#workspaces button.active {
  color: @base07;
  border-bottom: 2px solid @base0D;
}

#workspaces button.urgent {
  color: @base08;
  border-bottom: 2px solid @base08;
}

/* --- Dim secondary info, bright primary info --- */
#cpu,
#memory,
#mpris {
  color: @base04;
}

#clock {
  color: @base07;
}

/* --- Hover: just brighten the text --- */
#cpu:hover,
#memory:hover,
#mpris:hover,
#bluetooth:hover,
#network:hover,
#wireplumber:hover,
#battery:hover {
  color: @base07;
}

/* --- States --- */
#bluetooth {
  color: @base04;
  font-size: 15px;
}
#bluetooth.on {
  color: @base05;
}
#bluetooth.connected {
  color: @base0D;
}

#network.disconnected {
  color: @base08;
}

#wireplumber.muted {
  color: @base04;
}

#battery.charging {
  color: @base0B;
}
#battery.warning:not(.charging) {
  color: @base0A;
}
#battery.critical:not(.charging) {
  color: @base08;
}

#battery {
  margin-right: 6px;
}

/* --- Tooltip --- */
tooltip {
  background-color: @base01;
  color: @base05;
  border: 1px solid @base02;
  border-radius: 4px;
  padding: 4px 8px;
  font-size: 12px;
}

tooltip label {
  color: @base05;
}
''
