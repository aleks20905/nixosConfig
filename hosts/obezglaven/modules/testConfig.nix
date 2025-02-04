{ config, pkgs, ...}:

{

    environment.systemPackages = with pkgs; [
    

    # arduino
    # cura

    ];

    # services.xserver = {
    #     enable = true;
    #     videoDrivers = [ "amdgpu" ];  # Use "amdgpu" for modern AMD GPUs. If you're using an older AMD GPU, you might need "radeon".
    # };


    # services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';
    # services.xserver.xkbVariant = "bg";

  
    # services.xserver = {
    # enable = true;
    # xkb.layout = "us, bg";
    # xkb.variant = ",phonetic";

    # displayManager.sessionCommands = ''
    #     xrandr --output HDMI-A-2 --set "Broadcast RGB" "Full"
    # '';


    # xkb.options = "grp:win_space_toggle"; #! doest work ???

    # xrandrHeads = [ "DVI-D-1" "HDMI-A-2" ]; # Add both monitor identifiers
    
    # videoDrivers = [ "amdgpu" ]; # or "intel", "amdgpu", etc., depending on your hardware

    # config = ''
    #     Section "Monitor"
    #     Identifier "DVI-D-1"
    #     Option "PreferredMode" "1280x1024"
    #     EndSection
    #     Section "Monitor"
    #     Identifier "HDMI-A-2"
    #     Option "PreferredMode" "1920x1080_144.00"
    #     Option "TearFree" "true"
    #     Option "BroadcastRGB" "Full"
    #     EndSection
    #     '';
    # };
    
}