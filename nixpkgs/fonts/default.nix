{pkgs, ...}:{

    environment.systemPackages = with pkgs; [

        nerd-fonts.fantasque-sans-mono
    ];
}