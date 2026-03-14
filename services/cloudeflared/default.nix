{ config, pkgs, ... }: {

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };

  users.groups.cloudflared = { };

  systemd.services.my_tunnel = {
    description = "Cloudflare Tunnel Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    wants = [ "network-online.target" ];

    # THIS IS THE KEY LINE - don't restart during nixos-rebuild --- DO NOT FFING TOUCH IT OK 
    # if u ever need to restart it pray and do this: sudo systemctl restart my_tunnel
    restartIfChanged = false;

    serviceConfig = {
      EnvironmentFile = "/etc/cloudflared/tunnel-token.env";
      ExecStart =
        "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=$TUNNEL_TOKEN'";
      Restart = "always";
      RestartSec = "9s";
      User = "cloudflared";
      Group = "cloudflared";

      ProtectSystem = "strict";
      ProtectHome = true;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}

