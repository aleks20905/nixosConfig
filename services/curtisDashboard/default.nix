{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.curtisDashboard.nixosModules.default ];

  services.curtisDashboard = {
    enable = true;
    port = 8080;
    openFirewall = true;
    secretKeyFile = "/etc/curtisDashboard/secrets";
  };
}
# curl http://127.0.0.1:8080
# nix flake update curtisDashboard
#
#
# sudo rm /var/lib/curtisDashboard/production_data.xlsx
#
# -- creat secretKeyFile --
# sudo mkdir -p /etc/curtisDashboard
# sudo bash -c "echo SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_hex(32))') > /etc/curtisDashboard/secrets"
# sudo chmod 600 /etc/curtisDashboard/secrets
#
# -- check secretKeyFile --
# sudo cat /etc/curtisDashboard/secrets
