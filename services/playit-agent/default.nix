{ config, pkgs, ... }:

{

  # Enable OCI containers
  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      playit-tunnel = {
        autoStart = true;  # Starts automatically on boot

        image = "ghcr.io/playit-cloud/playit-agent:latest";  # Use the Playit image

        environment = {
          SECRET_KEY = "${builtins.getEnv "PLAYIT_SECRET"}";  # Fetch the secret from environment
        };

        extraArgs = [ "--net=host" ];

      };
    };
  };

}
