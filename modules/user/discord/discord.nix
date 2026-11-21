{ lib, ... }:
{
  flake.modules.homeManager = {
    vesktop = { pkgs, ... }: {
      home.packages = [ pkgs.vesktop ];
    };

    vesktop-x11 = { pkgs, ... }: {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "vesktop-x11";
          runtimeInputs = [ pkgs.vesktop ];
          text = ''
            exec vesktop --ozone-platform=x11 "$@"
          '';
        })
      ];
    };
  }

  // lib.genAttrs [ "discord" "discord-canary" "discord-ptb" ] (name:
    { pkgs, ... }: {
      home.packages = [ pkgs.${name} ];
    });
}
