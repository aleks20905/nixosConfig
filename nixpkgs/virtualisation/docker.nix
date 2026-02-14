{ config, pkgs, lib, ... }: {

  # Docker stuff rootles etc ... 
  virtualisation.docker = {
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs;
    [
    docker-compose
      # nixpacks # some type of conteriner shiet idk 'shity version of docker '
    ];

}
