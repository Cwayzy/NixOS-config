{
  flake.modules.homeManager.davinci-resolve = { pkgs, ... }: {
    home.packages = [ pkgs.davinci-resolve ];
    home.file.".local/share/DaVinciResolve/.keep".text = "";
  };

  flake.modules.homeManager.davinci-resolve-intel-gpu = {
    home.sessionVariables.OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors";
  };
}
