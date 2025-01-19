{pkgs, ...}:{

    environment.systemPackages = with pkgs; [

        libgcc
        gcc
        gdb
        stdenv
        gnumake

        # clang
        # valgrind
        # cmake
        # cppcheck

    ];

}