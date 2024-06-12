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

    # services.xserver = {
    #     enable = true;
    #     videoDrivers = [ "amdgpu" ];  # Use "amdgpu" for modern AMD GPUs. If you're using an older AMD GPU, you might need "radeon".
    # };

    # hardware.opengl = {
    #     enable = true;
    #     driSupport = true;
    #     driSupport32Bit = true;
    # };
 
    # services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';
   
}