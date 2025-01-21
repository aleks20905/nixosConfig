{pkgs, ...}:{

    environment.systemPackages = with pkgs; [

        go 

        # gosec # brutfocess some security problems for golang apps 

        templ

        air

        # golangci-lint
        # delve
    ];

}