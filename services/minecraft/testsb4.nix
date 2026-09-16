{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  modpack = pkgs.fetchFTBModpack {
    # Copy this URL from the pack's "Server Files" page
    url = "https://api.feed-the-beast.com/v1/modpacks/public/modpack/130/100501/server/linux";
    # You must fill this in on the first build; it will fail and tell you the hash
    packHash = "sha256-jx2rrXZQPGAQss5crJ3rBD2eC1znV2Z0trD5CXsdDz8=";
  };
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # https://github.com/vimjoyer/nixos-minecraft-server-video
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    # declarative = true;
    dataDir = "/var/lib/minecraftMine";

    # package = pkgs.papermcServers.papermc-1_21_5;

    servers = {
      sb4test = {

        enable = true;

        package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_248;


        symlinks = {
          "mods" = "${modpack}/mods";
        };
        files = modpack.serverFiles.files;

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };
        serverProperties = {
          # gamemode = "creative";
          gamemode = 0;
          # force-gamemode=true;
          difficulty = "normal";

          simulation-distance = 10;
          # level-type=ftbteamislands:void;
          # level-seed = "4";
          enable-command-block=true;

          # enable-rcon = true;
          # need to use mcrcon for remote console
          # "rcon.password" = "hunter2";

          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        jvmOpts = "-Xms1G -Xmx6G -XX:+UseG1GC " +
        "-XX:MaxGCPauseMillis=200 " +
        "-XX:G1PeriodicGCInterval=300000 " +
        "-XX:+G1PeriodicGCInvokesConcurrent " +
        "-XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20 " +
        "-XX:GCTimeRatio=4";
        # whitelist = {/* */};
      };

    };

  };

}