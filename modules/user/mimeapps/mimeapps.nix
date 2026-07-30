{ config, lib, ... }:
let
  cfg = config.modules.user.mimeapps;
in
{
  options.modules.user.mimeapps = {
    enable = mkEnableOption "Enable mimeapps";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";

        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";

        "application/pdf" = "org.pwmt.zathura.desktop";

        "inode/directory" = "thunar.desktop";

        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
      };
    };
  };
}
