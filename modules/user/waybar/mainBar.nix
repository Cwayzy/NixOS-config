{
  name = "mainBar";
  layer = "top";
  position = "top";
  output = "eDP-1";

  modules-left = [
  "hyprland/workspaces"
  "cpu"
  "memory"
  ];

  modules-center = ["clock"];

  modules-right = [
  "mpris" 
  "bluetooth"
  "network"
  "wireplumber"
  "battery"
  ];
}
