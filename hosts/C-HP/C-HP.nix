{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "C-HP";
}
