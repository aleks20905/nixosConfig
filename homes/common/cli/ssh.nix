{ pkgs, config, ... }: {

  home.packages = with pkgs; [ cloudflared ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = { };

      aleks-ssh-quantized = {
        hostname = "ssh.quantized.space";
        user = "aleks";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };

      qubits-ssh-quantized = {
        hostname = "ssh.quantized.space";
        user = "qubits";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };

    };

  };

}

# just why is this shiet beein changed like helo its a normal thing can u can reuse F this 
# extraConfig = ''
#   Host aleks-ssh-quantized
#     HostName ssh.quantized.space
#     User aleks 
#     ProxyCommand cloudflared access ssh --hostname %h

#   Host qubits-ssh-quantized
#     HostName ssh.quantized.space
#     User qubits
#     ProxyCommand cloudflared access ssh --hostname %h
# '';