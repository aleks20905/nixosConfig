{config, pkgs, ...}:{

    environment.systemPackages = with pkgs; [
        arduino
    ];

    # opens the ports so that u can upload sketches using arduino
    services.udev.extraRules = '' 
        KERNEL=="ttyACM0", MODE:="666"
    '';


}
