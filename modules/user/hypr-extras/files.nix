{ ... }:
{
  xdg.configFile."hypr/scripts" = {
    source = ./scripts;
    recursive = true;
  };

  xdg.configFile."hypr/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
}
