{
  flake.modules.nixos.usb = { pkgs, ... }: {
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      udiskie
    ];
  };
}
