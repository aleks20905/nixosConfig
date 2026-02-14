{ pkgs, lib, inputs, ... }: {

  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # https://github.com/vimjoyer/nixos-minecraft-server-video
  services.minecraft-servers = {

    enable = true;
    eula = true;
    openFirewall = true;
    # declarative = true;
    dataDir = "/var/lib/minecraftMine";

    servers = {
      cool-server1 = {
        # enable = true;
        package = pkgs.papermcServers.papermc-1_21_5;

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };

        serverProperties = {

          motd = "Obezglaven-nixos-mc";
          # gamemode = "creative";
          gamemode = 0;
          # force-gamemode=true;
          difficulty = "normal";

          simulation-distance = 10;
          # level-seed = "4";

          # enable-rcon = true;
          # need to use mcrcon for remote console
          # "rcon.password" = "hunter2";         

          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        symlinks = {
          "plugins/tabtps-spigot-1.3.27.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/cUhi3iB2/versions/DlhrDe98/tabtps-spigot-1.3.27.jar";
            sha256 = "1hm5wpsnrlzy4xqlgb9jwfj2gzrsq7xyg8l25dahk23ll0s9qsd5";
          };
          # "plugins/PlayerDoll-Main-2.3.jar" = pkgs.fetchurl {
          #    url = "https://cdn.modrinth.com/data/n3s2JUTc/versions/2N70Odp2/PlayerDoll-Main-2.3.jar";
          #    sha256 = "03m30w2sw1z1183xbvkvc5s7w1mk5dlqkc24yn5vnjvsbvg7q965";
          # };
          "plugins/SkinsRestorer.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/TsLS8Py5/versions/A177WPDH/SkinsRestorer.jar";
            sha256 = "1i5yx3wznzy69f9kc73vh71qdsw242w7r35bfxybx7ljbd0hsiwn";
          };

        };

        # whitelist = {/* */};
        # jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
        jvmOpts = lib.concatStringsSep " " [
          "-Xms1G"
          "-Xmx4G"
          "-XX:+UseG1GC"
          "-XX:+ParallelRefProcEnabled"
          "-XX:MaxGCPauseMillis=200"
          "-XX:+UnlockExperimentalVMOptions"
          "-XX:+DisableExplicitGC"
          "-XX:G1NewSizePercent=30"
          "-XX:G1MaxNewSizePercent=40"
          "-XX:G1HeapRegionSize=8M"
          "-XX:G1ReservePercent=20"
          "-XX:G1HeapWastePercent=5"
          "-XX:G1MixedGCCountTarget=4"
          "-XX:InitiatingHeapOccupancyPercent=15"
          "-XX:G1MixedGCLiveThresholdPercent=90"
          "-XX:G1RSetUpdatingPauseTimePercent=5"
          "-XX:SurvivorRatio=32"
          "-XX:+PerfDisableSharedMem"
          "-XX:MaxTenuringThreshold=1"
        ];
      };

      cool-servert-test1 = {
        # enable = true;
        package = pkgs.papermcServers.papermc-1_21_5;

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };

        serverProperties = {
          server-port = 20905;
          motd = "Obezglaven-nixos-mc";
          gamemode = 0;
          difficulty = "normal";

          simulation-distance = 10;
          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        symlinks = {
          "plugins/tabtps-spigot-1.3.27.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/cUhi3iB2/versions/DlhrDe98/tabtps-spigot-1.3.27.jar";
            sha256 = "1hm5wpsnrlzy4xqlgb9jwfj2gzrsq7xyg8l25dahk23ll0s9qsd5";
          };
          "plugins/SkinsRestorer.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/TsLS8Py5/versions/A177WPDH/SkinsRestorer.jar";
            sha256 = "1i5yx3wznzy69f9kc73vh71qdsw242w7r35bfxybx7ljbd0hsiwn";
          };

        };

        jvmOpts = lib.concatStringsSep " " [
          "-Xms1G"
          "-Xmx2G"
          "-XX:+UseG1GC"
          "-XX:+ParallelRefProcEnabled"
          "-XX:MaxGCPauseMillis=200"
          "-XX:+UnlockExperimentalVMOptions"
          "-XX:+DisableExplicitGC"
          "-XX:G1NewSizePercent=30"
          "-XX:G1MaxNewSizePercent=40"
          "-XX:G1HeapRegionSize=8M"
          "-XX:G1ReservePercent=20"
          "-XX:G1HeapWastePercent=5"
          "-XX:G1MixedGCCountTarget=4"
          "-XX:InitiatingHeapOccupancyPercent=15"
          "-XX:G1MixedGCLiveThresholdPercent=90"
          "-XX:G1RSetUpdatingPauseTimePercent=5"
          "-XX:SurvivorRatio=32"
          "-XX:+PerfDisableSharedMem"
          "-XX:MaxTenuringThreshold=1"
        ];
      };

      cool-server2 = {
        # enable = true;
        openFirewall = true;
        package = pkgs.fabricServers.fabric-1_21_5;

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };
        serverProperties = {
          server-port = 20905;
          motd = "Obezglaven-nixos-mc";
          gamemode = 0;
          difficulty = "normal";
          simulation-distance = 10;
          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        symlinks = {
          "plugins/tabtps-spigot-1.3.27.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/cUhi3iB2/versions/DlhrDe98/tabtps-spigot-1.3.27.jar";
            sha256 = "1hm5wpsnrlzy4xqlgb9jwfj2gzrsq7xyg8l25dahk23ll0s9qsd5";
          };
          "plugins/SkinsRestorer.jar" = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/TsLS8Py5/versions/A177WPDH/SkinsRestorer.jar";
            sha256 = "1i5yx3wznzy69f9kc73vh71qdsw242w7r35bfxybx7ljbd0hsiwn";
          };

        };

        jvmOpts = lib.concatStringsSep " " [
          "-Xms1G"
          "-Xmx4G"
          "-XX:+UseG1GC"
          "-XX:+ParallelRefProcEnabled"
          "-XX:MaxGCPauseMillis=200"
          "-XX:+UnlockExperimentalVMOptions"
          "-XX:+DisableExplicitGC"
          "-XX:G1NewSizePercent=20"
          "-XX:G1MaxNewSizePercent=30"
          "-XX:G1HeapRegionSize=4M"
          "-XX:G1ReservePercent=15"
          "-XX:G1HeapWastePercent=10"
          "-XX:G1MixedGCCountTarget=2"
          "-XX:InitiatingHeapOccupancyPercent=20"
          "-XX:SurvivorRatio=32"
          "-XX:+PerfDisableSharedMem"
          "-XX:MaxTenuringThreshold=1"
          "-Dusing.aikars.flags=https://mcflags.emc.gs"
          "-Daikars.new.flags=true"
          "-XX:+UseTransparentHugePages"
        ];
      };

      allthemods-server1 = {
        # enable = true;
        openFirewall = true;
        package =
          inputs.toyvo.packages.${pkgs.system}."neoforgeServers.neoforge-1_21_1";

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };
        serverProperties = {
          server-port = 20905;
          motd = "Obezglaven-nixos-mc";
          gamemode = 0;
          difficulty = "normal";
          simulation-distance = 10;
          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        symlinks = let
          modpack = (pkgs.fetchPackwizModpack {
            url =
              "https://raw.githubusercontent.com/aleks20905/atm10-test2/master/pack.toml";
            packHash = lib.fakeSha256;
          });
        in {
          "mods" = "${modpack}/mods";
          "config" = "${modpack}/config";
          "defaultconfigs" = "${modpack}/defaultconfigs";
          "kubejs" = "${modpack}/kubejs";
          "resourcepacks" = "${modpack}/resourcepacks";
        };

        jvmOpts = lib.concatStringsSep " " [ "-Xms4G" "-Xmx7G" ];
      };

      cool-server3 = {
        enable = true;
        openFirewall = true;
        package = pkgs.fabricServers.fabric-1_21_10;

        operators = {
          "aleks20905" = {
            uuid = "d021cdf9-249a-35a7-a7f2-4cd167be32c9";
            level = 4;
            bypassesPlayerLimit = true;
          };
        };
        serverProperties = {
          server-port = 33003;
          motd = "Obezglaven-nixos-mc";
          gamemode = 0;
          difficulty = "normal";
          simulation-distance = 10;
          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        # symlinks = {
        #   "plugins/tabtps-spigot-1.3.27.jar" = pkgs.fetchurl {
        #     url =
        #       "https://cdn.modrinth.com/data/cUhi3iB2/versions/DlhrDe98/tabtps-spigot-1.3.27.jar";
        #     sha256 = "1hm5wpsnrlzy4xqlgb9jwfj2gzrsq7xyg8l25dahk23ll0s9qsd5";
        #   };
        #   "plugins/SkinsRestorer.jar" = pkgs.fetchurl {
        #     url =
        #       "https://cdn.modrinth.com/data/TsLS8Py5/versions/A177WPDH/SkinsRestorer.jar";
        #     sha256 = "1i5yx3wznzy69f9kc73vh71qdsw242w7r35bfxybx7ljbd0hsiwn";
        #   };
        #
        # };

        jvmOpts = lib.concatStringsSep " " [
          "-Xms1G"
          "-Xmx3G"
          "-XX:+UseG1GC"
          "-XX:+ParallelRefProcEnabled"
          "-XX:MaxGCPauseMillis=200"
          "-XX:+UnlockExperimentalVMOptions"
          "-XX:+DisableExplicitGC"
          "-XX:G1NewSizePercent=20"
          "-XX:G1MaxNewSizePercent=30"
          "-XX:G1HeapRegionSize=4M"
          "-XX:G1ReservePercent=15"
          "-XX:G1HeapWastePercent=10"
          "-XX:G1MixedGCCountTarget=2"
          "-XX:InitiatingHeapOccupancyPercent=20"
          "-XX:SurvivorRatio=32"
          "-XX:+PerfDisableSharedMem"
          "-XX:MaxTenuringThreshold=1"
          "-Dusing.aikars.flags=https://mcflags.emc.gs"
          "-Daikars.new.flags=true"
          "-XX:+UseTransparentHugePages"
        ];
      };

    };

  };

}
