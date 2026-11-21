{
  flake.modules.homeManager.hyprland = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";

      extraLuaFiles = {
        autostart = import ./_autostart.nix;
        binds     = import ./_binds.nix;
        input     = import ./_input.nix;
        monitors  = import ./_monitors.nix;
        perms     = import ./_perms.nix;
        rules     = import ./_rules.nix;
        style     = import ./_style.nix;
      };
    };
  };
}
