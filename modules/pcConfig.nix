{ config, pkgs, ...}:

{
  

    environment.systemPackages = with pkgs; [
    
    steam
    
    # arduino
    # cura

    ];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };



    boot.initrd.kernelModules = [ "dm-snapshot" "amdgpu" ];

    services.xserver.enable =true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.xserver.deviceSection = ''
            Option "DRI" "3"
            Option "VariableRefresh" "true"
    '';
    hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    };
    

}