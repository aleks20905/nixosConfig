{ inputs, config, pkgs, ... }:
{



  imports = [ inputs.playit-nixos-module.nixosModules.default];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/aleks/.config/sops/age/keys.txt";

  sops.secrets.secret_key = {
    owner = "playit";
    group = "playit";
  };

  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.sops.secrets.secret_key.path;
    # secretPath = ./playit.toml ;
  };








}
