{config, lib, pkgs, ... }:
let
  cfg = config.modules.system.security;
in
{
  options.modules.system.security = {
    enable = lib.mkEnableOption "Enable security";
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.hyprlock = {};
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;

    environment.systemPackages = with pkgs; [
      libsecret
      seahorse
    ];
  };
}
