{
  flake.modules.homeManager.term-apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      aerc
      ani-cli
      brightnessctl
      btop
      fastfetch
      ffmpeg
      git
      imv
      killall
      libnotify
      ncdu
      pwvucontrol
      poppler-utils
      playerctl
      rsync
      mpv
      thunar
      tldr
      wl-clipboard
      yazi
      zathura
      zip unzip
      zenity
    ];
  };
}
