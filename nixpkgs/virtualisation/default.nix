{config, pkgs, lib, ...}: {

    # Docker stuff rootles etc ... 
    virtualisation.docker.rootless = {

        enable = true;
        setSocketVariable = true;
    };

    environment.systemPackages = with pkgs;[

        # nixpacks # some type of conteriner shiet idk 'shity version of docker '
    ]; 

}
