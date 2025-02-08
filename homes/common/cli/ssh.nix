{pkgs, config, ...}:{

<<<<<<< HEAD
    home.packages = with pkgs;[
        cloudflared 

    ];
=======

    environment.systemPackages = with pkgs; [ cloudflared ];
>>>>>>> 4c98d7a (testing ssh config)

    programs.ssh = {
        enable = true;

        extraConfig = ''
         Host aleks-ssh-quantized
            HostName ssh.quantized.space
            User aleks 
            ProxyCommand cloudflared access ssh --hostname %h

         Host qubits-ssh-quantized
            HostName ssh.quantized.space
            User qubits
            ProxyCommand cloudflared access ssh --hostname %h
        '';
    };

}