{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aerc
    ani-cli
    brightnessctl
    btop
    fastfetch
    git
    killall
    libnotify
    ncdu
    poppler-utils
    rsync
    yazi
    zip unzip
  ];
}
