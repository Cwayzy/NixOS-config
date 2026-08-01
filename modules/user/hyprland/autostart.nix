{
  content = ''
  hl.on("hyprland.start", function()
	  hl.exec_cmd("hyprlock & hyprpaper & waybar & hyprpolkitagent & mako & sunshine & hypridle & otd-daemon & betterdiscordctl install")
	  hl.exec_cmd("easyeffects --gapplication-service && sleep 3 && easyeffects --load-preset fifine_mic")
  end)
  '';
  autoLoad = true;
}
