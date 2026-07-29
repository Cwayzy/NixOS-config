{
  content = ''
  hl.on("hyprland.start", function()
	  hl.exec_cmd("hyprlock & waybar & hyprpaper & mako & sunshine & hypridle & otd-daemon & betterdiscordctl install")
	  hl.exec_cmd("easyeffects --gapplication-service && sleep 3 && easyeffects --load-preset fifine_mic")
    hl.exec_cmd("swaybg -i $HOME/.config/hypr/wallpapers/dreamy.png -m fill")
  end)
  '';
  autoLoad = true;
}
