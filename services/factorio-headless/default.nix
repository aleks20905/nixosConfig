{ config, pkgs, inputs, lib, ... }:
let

  oldPkgs = import inputs.oldNixpkgs {
    system = pkgs.system;
    config = { allowUnfree = true; };
  };
in {

  environment.systemPackages = with oldPkgs; [ factorio-headless ];

  services.factorio = {

    package = oldPkgs.factorio-headless;

    enable = true;
    public = false;
    requireUserVerification = false;
    lan = true;
    openFirewall = true;
    stateDirName = "factorio-conf";
    # saveName = "test_saves";
    saveName = "minesave";
    admins = [ "aleks" ];
    nonBlockingSaving = true;

  };
  # sudo ls /var/lib/private/factorio/saves 
  # sudo cp /home/aleks/long\ time\ not\ see\ this\ world.zip /var/lib/private/factorio/saves  
  #  scp long\ time\ not\ see\ this\ world.zip aleks@aleks-ssh-quantized:/home/aleks с
}
