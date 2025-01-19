{pkgs, ...}:{


    environment.systemPackages = with pkgs;[

        vscode
        vscode-fhs
        vscode-runner
    
    ];



}


