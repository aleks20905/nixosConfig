{ pkgs, lib, inputs, ... }:
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
      cool-server1 = {
        enable = true;
        package = pkgs.papermcServers.papermc-1_21_5;

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
          # level-seed = "4";

          # enable-rcon = true;
          # need to use mcrcon for remote console
          # "rcon.password" = "hunter2";         
    
          online-mode = false; # aaaa tf acc not working HELO...
          allow-cheats = true;
        };

        jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
        # whitelist = {/* */};
      };

    };




  };

 }