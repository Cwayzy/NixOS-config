{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.browser;
  cfg = config.modules.user.browser.brave;
in
{
  options.modules.user.browser.brave = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = parentCfg.enable;
      description = "Enable brave";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
        { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7TV
        { id = "ajopnjidmegmdimjlfnijceegpefgped"; } # BetterTTV
      ];
    };
  };
}
