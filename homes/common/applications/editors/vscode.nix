{pkgs, ...}:{


    home.packages = with pkgs;[

        # vscode # cant have vscode and vscode-fhs and the same time when installed from home-manager
        vscode-fhs
        vscode-runner
    
    ];



}


