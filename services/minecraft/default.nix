{ pkgs, lib, ...}:{
# https://github.com/vimjoyer/nixos-minecraft-server-video
  services.minecraft = {
    enable = true;
    eula = true;
    declarative = true;

    package = pkgs.papermcServers.papermc-1_21_1;

    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10;
      level-seed = "4";
    };

    jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";



  }

}