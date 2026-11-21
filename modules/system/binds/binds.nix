{
  flake.modules.nixos.binds = {
    services.keyd = {
      enable = true;

      keyboards.default = {
        ids = [ "*" ];

        settings = {
          main = {
            capslock = "layer(hyper)";
            "leftshift+rightshift" = "capslock";
            pageup = "f13";
            pagedown = "f14";
          };

          "hyper:C-M-A-S" = {};
        };
      };
    };
  };
}
