{
  pkgs,
  lib,
  ...
}:

let
  pythonEnv = pkgs.python3.withPackages (ps: [ ps.mcstatus ]);
  statusScript = ./status.py;
in
{

  systemd.services.minecraft-status = {
    description = "Minecraft server status API";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pythonEnv}/bin/python3 ${statusScript}";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

}
