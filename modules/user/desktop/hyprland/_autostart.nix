{
  content = ''
  hl.on("hyprland.start", function()
	  hl.exec_cmd("hyprpaper & waybar & hyprpolkitagent & mako & sunshine & hypridle & otd-daemon & udiskie --tray & betterdiscordctl install")
    hl.exec_cmd("pidof hyprlock || hyprlock")
  end)
  '';
  autoLoad = true;
}
