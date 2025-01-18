{config, lib, pkgs, ...}:{

    # installs steam 
    programs.steam = {
        enable = true;
        gamescopeSession.enable = true; # enables gamescope for smoother experience
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # enables gameMode for smoother experience
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [

        protonup # thing to download/update porton 

        wineWowPackages.stable # wine translation layer ...

        mangohud # see gpu usage etc frame time top left

    ];

    # sets where to download the "proton " layer 
    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };

    # options that u can run with steam
    # gamemoderun %command%
    # mangohud %command%
    # gamescope %command%
}

