{ config, pkgs, ... }:
{
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
    
    serviceConfig = {
      EnvironmentFile = "/etc/cloudflared/tunnel-token.env";
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=$TUNNEL_TOKEN'";
      Restart = "always";
      RestartSec = "30s";
      User = "cloudflared";
      Group = "cloudflared";
      
      # Security options
      ProtectSystem = "strict";
      ProtectHome = true;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };

}
