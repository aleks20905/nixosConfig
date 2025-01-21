{ config, pkgs, ... }:

{
    # might need to restart system to work | - sometimes works sometimes doest idk
    environment.systemPackages = [ pkgs.via ];

#   services.udev.packages = [ pkgs.via ];

    # services.udev.extraRules = ''
    # SUBSYSTEM=="usb", ATTR{idVendor}=="424c", ATTR{idProduct}=="5343", MODE="0666"
    # '';
}