{
  config,
  lib,
  ...
}:

{

  services.homepage-dashboard = {
    enable = true;

    settings = {
      title = "obezglaven";
      headerStyle = "clean";
      color = "slate";
      theme = "dark";
      layout = {
        Infrastructure = {
          style = "row";
          columns = 3;
        };
        Gaming = {
          style = "row";
          columns = 2;
        };
        Apps = {
          style = "row";
          columns = 3;
        };
      };
    };

    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
          label = "obezglaven";
        };
      }
    ];

    services = [
      {
        Infrastructure = [
          {
            SSH = {
              icon = "ssh";
              href = "ssh://aleks@localhost";
              description = "OpenSSH on port 22";
            };
          }
          {
            "Cloudflare Tunnel" = {
              icon = "cloudflare";
              description = "Cloudflare tunnel service";
              statusStyle = "dot";
              url = "http://localhost:8082";
            };
          }
          {
            Minecraft = {
              icon = "minecraft";
              href = "minecraft://localhost";
              description = "PaperMC server on port 25565";
            };
          }
        ];
      }
      {
        Gaming = [
          {
            Factorio = {
              icon = "factorio";
              href = "factorio://localhost";
              description = "Headless server on port 34197";
            };
          }
        ];
      }
      {
        Apps = [
          {
            GOTTH = {
              icon = "gotth";
              href = "http://localhost:4000";
              description = "Reverse proxy on port 4000";
            };
          }
          {
            "Curtis Dashboard" = {
              icon = "dashboard";
              href = "http://localhost:8080";
              description = "Curtis Dashboard on port 8080";
            };
          }
          {
            "Playit Agent" = {
              icon = "playit";
              description = "Play.it tunnel agent (currently disabled)";
            };
          }
          {
            Arduino = {
              icon = "arduino";
              description = "Arduino development (currently disabled)";
            };
          }
        ];
      }
    ];

    docker = {
      host = "unix:///var/run/docker.sock";
    };
  };

}
