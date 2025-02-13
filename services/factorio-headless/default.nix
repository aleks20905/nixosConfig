{config, pkgs, ...}:{

    environment.systemPackages = with pkgs; [

        factorio-headless
    ];

    services.factorio = {
        enable = true;
        public = false;
        requireUserVerification = false;
        lan = true;
        openFirewall = true;
        stateDirName = "factorio-conf";
        saveName = "test_saves"; 
        admins = ["aleks"];
        nonBlockingSaving = true;

    };



}
