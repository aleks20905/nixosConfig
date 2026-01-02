{ pkgs, ... }: {

  home.packages = with pkgs; [

    google-chrome

    firefox

    tor-browser

  ];

}

