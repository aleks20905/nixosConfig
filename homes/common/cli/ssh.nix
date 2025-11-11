{pkgs, config, ...}:{


    home.packages = with pkgs; [ cloudflared ];

    programs.ssh = {
        # enable = true; # removed cuz eval warning idk mate like ff off i dont giva fuck u just want this shit to work and not scream at me for no reason stupit BS 

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
