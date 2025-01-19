{pkgs, ...}:{


    # Disable X11 if not needed
    # services.xserver.enable = false;

    # Enable the KDE Plasma Desktop Environment.
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        plasma-browser-integration
        oxygen
    ];



}