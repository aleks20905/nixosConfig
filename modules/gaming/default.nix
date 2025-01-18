{config, lib, pkgs, ...}:{

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [

        protonup # thing to download porton 

        wineWowPackages.stable # wine translation layer ...

        mangohud # see gpu usage etc frame time top left


    ];

    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };

    # options that u can run with steam
    # gamemoderun %command%
    # mangohud %command%
    # gamescope %command%
}

