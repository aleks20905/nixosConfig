{pkgs, ...}:{

    services.xserver.videoDrivers = ["amdgpu"];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        # driSupport32Bit = true;
    };


}