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

      services.spice-autorandr.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    displayManager.lightdm.enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.plasma5.enable = true;

    # X11 display configuration
    videoDrivers = [ "amdgpu" ]; # Using the AMD GPU driver

    monitorSection = ''
      Section "Monitor"
          Identifier "HDMI-0"
          Option "Primary" "true"
          Option "PreferredMode" "1920x1080_144.00"
      EndSection

      Section "Monitor"
          Identifier "DVI-I-1"
          Option "PreferredMode" "1280x1024_60.00"
      EndSection

      Section "Screen"
          Identifier "Screen0"
          Device "Device0"
          Monitor "HDMI-0"
          DefaultDepth 24
          SubSection "Display"
              Depth 24
              Modes "1920x1080_144.00"
          EndSubSection
      EndSection

      Section "Screen"
          Identifier "Screen1"
          Device "Device1"
          Monitor "DVI-I-1"
          DefaultDepth 24
          SubSection "Display"
              Depth 24
              Modes "1280x1024_60.00"
          EndSubSection
      EndSection

      Section "Device"
          Identifier "Device0"
          Driver "amdgpu"
          BusID "PCI:1:0:0"
      EndSection

      Section "Device"
          Identifier "Device1"
          Driver "amdgpu"
          BusID "PCI:2:0:0"
      EndSection

      Section "ServerLayout"
          Identifier "Layout0"
          Screen 0 "Screen0"
          Screen 1 "Screen1" RightOf "Screen0"
      EndSection
    '';
  };

   
}