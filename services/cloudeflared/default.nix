{ config, pkgs, ... }:

let
  token = builtins.readFile ./tocken.txt;  # Create a token.txt file with just the token
in

{
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };

  users.groups.cloudflared = { };

  systemd.services.my_tunnel = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=${token}";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
