{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [
    "ntsync"
    "amdgpu"
  ];
  boot.extraModulePackages = [ ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;

  boot.kernelParams = [
    "mitigations=off"
    #   "video=HDMI-A-2:1920x1080@144"
    #   "video=DVI-D-1:1280x1024@60"
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.fstrim.enable = true; # Enable periodic TRIM for SSDs defalt = "weekly".

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/487bcdb3-43a4-4c28-94a2-8594b7617fad";
    fsType = "ext4";
  };

  # swapDevices = [{
  # 	device = "/swapfile";
  # 	size = 16 * 1024; # 16GB
  # }];

  fileSystems."/mnt/hdd1" = {
    device = "/dev/disk/by-uuid/2CAAD7C4AAD788AA ";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "umask=0022"
      "windows_names"
      "big_writes"
    ];
  };

  # lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,UUID 

  fileSystems."/mnt/ssd1" = {
    device = "/dev/disk/by-uuid/660AC37D0AC348AF ";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "umask=0022"
      "windows_names"
      "big_writes"
    ];
  };

  # fileSystems."/mnt/nvme0" = {
  # 	device = "/dev/disk/by-uuid/1d5ace25-3c86-495b-acb5-26b1601a17c4";
  # 	fsType = "ext4";
  # 	options = [ "defaults" "nofail" ];
  # };

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0u7.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
