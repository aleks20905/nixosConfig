{ config, pkgs, ... }:

{

  systemd.services.playit-agent = {
    description = "Playit Tunnel Service for Factorio";
    after = [ "network.target" "docker.service" ];
    wants = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "/bin/sh -c 'docker run --rm --net=host -e SECRET_KEY=$PLAYIT_SECRET ghcr.io/playit-cloud/playit-agent:latest'";
      Restart   = "always";
    };

    # explicitly set the environment variable 
    # environment = {
    #   PLAYIT_SECRET = "your_actual_secret_key_here";
    # };
  };
}
