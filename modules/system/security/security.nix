{
  flake.modules.nixos.security = { pkgs, ... }: {
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
