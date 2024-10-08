
{ config, pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    pgadmin4 # postgreSQL tool konda works
  ];

  services.postgresql.settings = {
    enable = true;
    ensureDatabases = [ "gotest" ];
    port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      #type database DBuser origin-address auth-method
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
      '';
  };


}