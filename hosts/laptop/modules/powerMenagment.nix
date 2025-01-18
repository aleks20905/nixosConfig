{ config, pkgs, ...}:

{
    networking.networkmanager.wifi.powersave = true; 
    
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    
    
    #POWER PROFILE 
    # services.power-profiles-daemon.enable = false; 
    # services.tlp = {
    #     enable = true;
    #     settings = {

    #         # CPU Governor
    #         CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #         CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";  # Balanced but more responsive

    #         # Energy Performance Policy
    #         CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";  # Prioritizes performance a bit more
    #         CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

    #         # Performance Limits
    #         CPU_MIN_PERF_ON_AC = 100;
    #         CPU_MAX_PERF_ON_AC = 100;
    #         CPU_MIN_PERF_ON_BAT = 40;  # Higher minimum performance on battery
    #         CPU_MAX_PERF_ON_BAT = 70;

    #         # Battery Charge Thresholds (Optional)
    #         START_CHARGE_THRESH_BAT0 = 80;  # Start charging at 80% and below
    #         STOP_CHARGE_THRESH_BAT0 = 90;  # Stop charging at 90% and above

    #     };
    # };

    # #saves a little more power than normaly but makes the system just too much laggy
    # services.auto-cpufreq.enable = true;
    # services.auto-cpufreq.settings = {
    #     battery = {
    #         governor = "powersave";
    #         turbo = "auto";
    #     };
    #     charger = {
    #         governor = "performance";
    #         turbo = "auto";
    #     };
    # };  



}