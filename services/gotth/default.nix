{
  inputs,
  pkgs,
  # gotth,
  ...
}:
{
  imports = [ inputs.gotth.nixosModules.default ];

  services.goth = {
    enable = true;
    port = 4000;
    openFirewall = true; # Opens port 4000
  };
}
