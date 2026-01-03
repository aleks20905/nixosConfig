{ pkgs, ... }: {

  home.packages = with pkgs;
    [

      # nvtop
      nvtopPackages.amd
    ];
}
