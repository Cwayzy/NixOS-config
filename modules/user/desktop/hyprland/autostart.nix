{
  content = ''
  hl.on("hyprland.start", function()
	  hl.exec_cmd("hyprpaper & waybar & hyprpolkitagent & mako & sunshine & hypridle & otd-daemon & udiskie --tray & betterdiscordctl install")
	  hl.exec_cmd("easyeffects --gapplication-service && sleep 3 && easyeffects --load-preset fifine_mic")
    hl.exec_cmd("pidof hyprlock || hyprlock")
  end)
  '';
  autoLoad = true;
}
