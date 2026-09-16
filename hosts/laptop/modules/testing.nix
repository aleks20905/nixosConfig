{
  # config,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    # ventoy-full-qt
    # ntfs3g
    # cura
    # atlauncher
    # prismlauncher
    # mcrcon
    # path-of-building
    libreoffice-qt
    moonlight-qt
    opencode
  ];

  # zramSwap = {
  #     enable = true;
  #     memoryPercent = 50; # Use up to 50% of RAM for compressed swap
  # };
}
