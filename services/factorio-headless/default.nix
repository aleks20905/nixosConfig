{ config, pkgs, inputs, lib, ... }:
let

  oldPkgs = import inputs.factorio-updateNixpkgs {
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
    saveName = "test_saves";
    admins = [ "aleks" ];
    nonBlockingSaving = true;

  };

}
