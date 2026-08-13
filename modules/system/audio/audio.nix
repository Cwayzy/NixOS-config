{ config, lib, pkgs, ...}:
let
  cfg = config.modules.system.audio;
in
{
  options.modules.system.audio = {
    enable = lib.mkEnableOption "Pipewire/Wireplumber audio stack";

    hpEliteBookQuirks = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "fix elitebook specific fixes";
    };
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

    services.pulseaduio.enable = false;

    enviorment.systemPackages = with pkgs; [
      pwvucontrol
      wireplumber
      pavucontrol
    ];

    boot.extraModprobeConfig = lib.mkIf cfg.hpEliteBookQuirks ''
      options intel_hid enable_5_button_array=1
    '';

    boot.kernelPackages = mkIf cfg.hpEliteBookQuirks (lib.mkDefault pkgs.linuxPackages_latest);
  };
}
