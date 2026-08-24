{ config, lib, pkgs, ...}:
let
  cfg = config.modules.system.audio;
in
{
  options.modules.system.audio = {
    enable = lib.mkEnableOption "Pipewire/Wireplumber audio stack";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
      wireplumber.enable = true;
    };

    services.pulseaudio.enable = false;

    environment.systemPackages = with pkgs; [
      pwvucontrol
      wireplumber
      pavucontrol
    ];
  };
}
