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
              icon = "mdi-console";
              description = "OpenSSH on port 22";
              url = "tcp://localhost:22";
            };
          }
          {
            "Cloudflare Tunnel" = {
              icon = "mdi-cloud";
              description = "Cloudflare tunnel service";
            };
          }
          {
            Minecraft = {
              icon = "mdi-minecraft";
              description = "PaperMC server on port 25565";
              url = "tcp://localhost:25565";
            };
          }
        ];
      }
      {
        Gaming = [
          {
            Factorio = {
              icon = "mdi-gamepad-variant";
              description = "Headless server on port 34197";
            };
          }
        ];
      }
      {
        Apps = [
          {
            GOTTH = {
              icon = "mdi-web";
              description = "Lightweight web app on port 4000";
              url = "http://localhost:4000";
            };
          }
          {
            "Curtis Dashboard" = {
              icon = "mdi-view-dashboard";
              description = "Curtis Dashboard on port 8080";
              url = "http://localhost:8080";
            };
          }
          {
            "Playit Agent" = {
              icon = "mdi-tunnel";
              description = "Play.it tunnel agent";
            };
          }
          {
            Arduino = {
              icon = "mdi-chip";
              description = "Arduino development";
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
