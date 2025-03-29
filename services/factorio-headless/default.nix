{config, pkgs, inputs, lib, ...}:
let

    oldPkgs = import inputs.oldNixpkgs {
        system = pkgs.system;
        config = { allowUnfree = true; };
    };
in 
{

    environment.systemPackages = with oldPkgs; [

        factorio-headless
    ];

    services.factorio = {
        enable = true;
        public = false;
        requireUserVerification = false;
        lan = true;
        openFirewall = true;
    };



}