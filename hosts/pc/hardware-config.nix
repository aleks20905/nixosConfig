# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "amdgpu" ]; # might need to change idk # TODO 
	boot.extraModulePackages = [ ];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	# boot.kernelPackages = pkgs.linuxPackages_zen;
	# boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;

	# boot.kernelParams = [
	#   "video=HDMI-A-2:1920x1080@144"
	#   "video=DVI-D-1:1280x1024@60"
	# ];

	# hardware.gpu.amd.enable = true;

	# hardware.graphics.extraPackages = [
	#   pkgs.amdvlk
	# ];

	# # To enable Vulkan support for 32-bit applications, also add:
	# hardware.graphics.extraPackages32 = [
	#   pkgs.driversi686Linux.amdvlk
	# ];

	# Force radv
	# environment.variables.AMD_VULKAN_ICD = "RADV";
	# # Or
	# environment.variables.VK_ICD_FILENAMES =
	#   "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
	
	
	#  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "pc"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	
	fileSystems."/" = {

		device = "/dev/disk/by-uuid/487bcdb3-43a4-4c28-94a2-8594b7617fad";
		fsType = "ext4";
	};

	swapDevices = [{
		device = "/swapfile";
		size = 16 * 1024; # 16GB
	}];

	fileSystems."/mnt/hdd1" = {
		device = "/dev/disk/by-uuid/2CAAD7C4AAD788AA ";
		fsType = "ntfs-3g";
		options = [ "uid=1000" "gid=100" "umask=0022" "windows_names" "big_writes" ];
	};

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp2s0f0u7.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
