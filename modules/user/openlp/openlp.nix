{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.openlp;

  openlpFHS = pkgs.buildFHSUserEnv {
    name = "openlp";

    targetPkgs = pkgs: with pkgs; [
      python3
      python3Packages.pip
      stdenv.cc.cc.lib
      zlib
      libGL
      fontconfig
      freetype
      glib
      dbus
      nss
      nspr
      alsa-lib
      libpulseaudio
      vlc
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libxcb
      xorg.libSM
      xorg.libICE
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXtst
    ];

    runScript = pkgs.writeShellScript "openlp-launcher" ''
    export QT_QPA_PLATFORM=xcb
    VENV_DIR="$HOME/.local/share/openlp-venv"

    if [ ! -d "$VENV_DIR" ]; then 
      echo "Setting up OpenLP (first run)..."
      python3 -m venv "$VENV_DIR"
      "$VENV_DIR/bin/pip" install --upgrade pip
      "$VENV_DIR/bin/pip" install openlp
    fi

    exec "$VENV_DIR/bin/openlp" "$@"
    '';
  };
in
{
  options.modules.user.openlp = {
      enable = lib.mkEnableOption " enable OpenLP";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ openFHS ];

    xdg.desktopEntries.openlp = {
      name = "OpenLP";
      comment = "Free church presentation software";
      exec = "openlp";
      icon = "openlp";
      terminal = false;
      categories = [ "AudioVideo" "Presentation" ];
    };
  };
}
