{
  flake.modules.homeManager.waybar = {
    programs.waybar = {
      enable = true;
      settings.mainBar = (import ./_mainBar.nix) // (import ./_modules.nix);
      style = import ./_style.nix;
    };

    xdg.configFile."waybar/secondBar.json".text = builtins.toJSON (
      (import ./_secondBar.nix) // (import ./_modules.nix)
    );
  };
}
