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
      wireplumber = {
        enable = true;
        extraConfig."51-audio-cleanup" = {
          "monitor.alsa.rules" = [
            # Disable devices 
            {
              matches = [
                { "device.name" = "alsa_card.pci-0000_08_00.1"; } # GA104 HDMI
                { "device.name" = "alsa_card.pci-0000_0a_00.4"; } # Starship/Matisse
              ];
              actions.update-props = { "device.disabled" = true; };
            }

            #Disable nodes
            {
              matches = [ { "node.name" = "~alsa_input.usb-Focusrite_Scarlett_Solo_USB_.*"; } ];
              actions.update-props = { "node.disabled" = true; };
            }

            # Rename nodes
            {
              matches = [ { "node.name" = "~alsa_output.usb-Focusrite_Scarlett_Solo.*"; } ];
              actions.update-props = {
                "node.description" = "Headphones";
                "node.nick" = "Headphones";
              };
            }
            {
              matches = [ { "node.name" = "~alsa_input.usb-.*USB_PnP_Audio_Device.*"; } ];
              actions.update-props = {
                "node.description" = "Mic";
                "node.nick" = "Mic";
              };
            }
          ];
        };
      };
    };

    services.pulseaudio.enable = false;

    environment.systemPackages = with pkgs; [
      pwvucontrol
      wireplumber
    ];
  };
}
