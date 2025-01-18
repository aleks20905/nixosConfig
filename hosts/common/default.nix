{inputs, config, lib, ...}: {
    imports = [ 
        inputs.home-manager.nixosModules.default
    ];

    home-manager = {
        extraSpecialArgs = {inherit inputs;};
        users ={
        "aleks"  = import ./home.nix;
        };
    };

}