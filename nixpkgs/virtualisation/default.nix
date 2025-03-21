{config, pkgs, lib, ...}: {

    # Docker stuff rootles etc ... 
    virtualisation.docker.rootless = {

        enable = true;
        setSocketVariable = true;
    };

    environment.systemPackages = with pkgs;[

        # nixpacks # some type of conteriner shiet idk 'shity version of docker '
    ]; 

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["aleks"];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

}
