{ pkgs, ... }: {

  # installs steam 
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true; # enables gamescope for smoother experience
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports for Source Dedicated Server
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [

    protonup-ng # thing to download/update porton

    wineWow64Packages.full # wine translation layer ...
    winetricks

    # protontricks

    mangohud # see gpu usage etc frame time top left

    # lutris # lutris game launcher 
    heroic
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
  # PROTON_ENABLE_WAYLAND=1 WINEDEBUG=-all DXVK_ASYNC=1 STAGING_SHARED_MEMORY=1 gamemoderun %command%
  # PROTON_ENABLE_WAYLAND=1 gamemoderun %command%
}

