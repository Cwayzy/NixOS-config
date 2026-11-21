{
  flake.modules.homeManager.mimeapps = {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "brave.desktop";
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "x-scheme-handler/about" = "brave.desktop";
        "x-scheme-handler/unknown" = "brave.desktop";

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
