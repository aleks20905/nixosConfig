{config, lib, ...}: {

    # Docker stuff rootles etc ... 
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
 

}
