{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    extraLuaFiles   = {
      autostart     = import ./autostart.nix;
      binds         = import ./binds.nix;
      input         = import ./input.nix;
      monitors      = import ./monitors.nix;
      perms         = import ./perms.nix;
      rules         = import ./rules.nix;
      style         = import ./style.nix;
    };
  };
}
