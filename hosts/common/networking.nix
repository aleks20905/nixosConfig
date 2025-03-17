{ config, lib, ... }:
{

    networking.networkmanager.enable = true;

    networking.networkmanager.dns = "none";
    # These options are unnecessary when managing DNS ourselves
    networking.useDHCP = false;
    networking.dhcpcd.enable = false;

    networking.nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "9.9.9.9"

        "2606:4700:4700::1111#cloudflare-dns.com"
        "2606:4700:4700::1001#cloudflare-dns.com"
        "2620:fe::fe#dns.quad9.net"
        "2620:fe::9#dns9.quad9.net"
    ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # networking.firewall = {
    #     enable = true;

    #     allowedTCPPortRanges = [
    #         { from = 49152; to = 65535; }
    #     ];

    #     allowedUDPPortRanges = [
    #         { from = 49152; to = 65535; }
    #     ];
    # };


}