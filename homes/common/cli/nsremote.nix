{ config, lib, pkgs, ... }:

let
  remotes = {
    obezglaven = "obezglaven";
    # nas = "nas-alias";
  };

  remotesBash = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (name: host: "  [${name}]=\"${host}\"") remotes);

  hostNames = lib.concatStringsSep " " (lib.attrNames remotes);

  flakePath = "$HOME/Desktop/nixosConfig";

  nsremoteScript = pkgs.writeShellApplication {
    name = "nsremote";
    runtimeInputs = [ pkgs.nixos-rebuild pkgs.openssh ];
    text = ''
      RED='\033[0;31m'
      YELLOW='\033[0;33m'
      CYAN='\033[0;36m'
      NC='\033[0m'

      declare -A REMOTES=(
      ${remotesBash}
      )

      usage() {
        echo -e "''${CYAN}nsremote''${NC} - Remote NixOS rebuild wrapper"
        echo ""
        echo -e "''${YELLOW}Usage:''${NC} nsremote <action> <host> [local]"
        echo ""
        echo -e "''${YELLOW}Actions:''${NC}"
        echo "  switch  Deploy config and activate immediately"
        echo "  test    Activate config but revert on reboot (safe testing)"
        echo "  boot    Stage config for next boot (no immediate change)"
        echo "  diff    Show package changes between current and new config"
        echo "  gc      Garbage collect old generations (frees disk space)"
        echo ""
        echo -e "''${YELLOW}Hosts:''${NC}"
        for k in "''${!REMOTES[@]}"; do
          echo "  $k"
        done
        echo ""
        echo -e "''${YELLOW}Build location (optional, 3rd arg):''${NC}"
        echo "  remote (default)  Build on the target host"
        echo "  local             Build on this machine, deploy to target"
        echo ""
        echo -e "''${YELLOW}Examples:''${NC}"
        echo -e "  ''${GREEN}nsremote switch obezglaven''${NC}"
        echo "    Deploy to server, build on the server (default)"
        echo ""
        echo -e "  ''${GREEN}nsremote switch obezglaven local''${NC}"
        echo "    Deploy to server, build locally on this machine"
        echo "    Useful when the server is slow or underpowered"
        echo ""
        echo -e "  ''${GREEN}nsremote test obezglaven''${NC}"
        echo "    Try a config safely - reverts on reboot"
        echo ""
        echo -e "  ''${GREEN}nsremote boot obezglaven local''${NC}"
        echo "    Stage config for next planned reboot"
        echo ""
        echo -e "  ''${GREEN}nsremote diff obezglaven''${NC}"
        echo "    Preview what a rebuild would change"
        echo ""
        echo -e "  ''${GREEN}nsremote gc obezglaven''${NC}"
        echo "  Free disk space by removing old generations (>30d)"
        exit 1
      }

      build_args_for() {
        if [ "$2" = "local" ]; then
          echo ""
        else
          echo "--build-host $1"
        fi
      }

      remote_switch() {
        local host="$1" location="$2"
        local build_args
        build_args=$(build_args_for "$host" "$location")
        # shellcheck disable=SC2086
        nixos-rebuild switch --flake "${flakePath}#$host" \
          --target-host "$host" $build_args --ask-elevate-password
      }

      remote_test() {
        local host="$1" location="$2"
        local build_args
        build_args=$(build_args_for "$host" "$location")
        # shellcheck disable=SC2086
        nixos-rebuild test --flake "${flakePath}#$host" \
          --target-host "$host" $build_args --ask-elevate-password
      }

      remote_boot() {
        local host="$1" location="$2"
        local build_args
        build_args=$(build_args_for "$host" "$location")
        # shellcheck disable=SC2086
        nixos-rebuild boot --flake "${flakePath}#$host" \
          --target-host "$host" $build_args --ask-elevate-password
      }

      remote_diff() {
        local host="$1"
        ssh "$host" 'nix profile diff-closures --profile /nix/var/nix/profiles/system'
      }

      remote_gc() {
        local host="$1"
        ssh "$host" 'sudo nix-collect-garbage --delete-older-than 30d'
      }

      [ $# -lt 2 ] && usage

      action="$1"
      host_key="$2"
      location="''${3:-remote}"

      if [ -z "''${REMOTES[$host_key]:-}" ]; then
        echo -e "''${RED}Unknown host: $host_key''${NC}"
        usage
      fi
      host="''${REMOTES[$host_key]}"

      case "$location" in
        local|remote) ;;
        *)
          echo -e "''${RED}Unknown build location: $location (use 'local' or 'remote')''${NC}"
          usage
          ;;
      esac

      case "$action" in
        switch) remote_switch "$host" "$location" ;;
        test)   remote_test "$host" "$location" ;;
        boot)   remote_boot "$host" "$location" ;;
        diff)   remote_diff "$host" ;;
        gc)     remote_gc "$host" ;;
        *)
          echo -e "''${RED}Unknown action: $action''${NC}"
          usage
          ;;
      esac
    '';
  };

  nsremoteCompletion = pkgs.writeTextFile {
    name = "nsremote-completion";
    destination = "/share/zsh/site-functions/_nsremote";
    text = ''
      #compdef nsremote

      _nsremote() {
        local -a actions hosts locations

        actions=(
          'switch:Deploy config and activate immediately'
          'test:Activate config but revert on reboot'
          'boot:Stage config for next boot'
          'diff:Show package changes'
          'gc:Garbage collect old generations'
        )

        hosts=(${hostNames})
        locations=(local remote)

        case $CURRENT in
          2) _describe 'action' actions ;;
          3) _describe 'host' hosts ;;
          4) _describe 'build location' locations;;
        esac
      }

      _nsremote "$@"
    '';
  };
in
{
  home.packages = [ nsremoteScript nsremoteCompletion ];
}

# Quick reference:
#
# nsremote switch obezglaven        -> nixos-rebuild switch --flake .#obezglaven --target-host obezglaven --build-host obezglaven
# nsremote switch obezglaven local  -> nixos-rebuild switch --flake .#obezglaven --target-host obezglaven
# nsremote test   obezglaven        -> nixos-rebuild test   --flake .#obezglaven --target-host obezglaven --build-host obezglaven
# nsremote boot   obezglaven local  -> nixos-rebuild boot   --flake .#obezglaven --target-host obezglaven
# nsremote diff   obezglaven        -> ssh obezglaven 'nix profile diff-closures --profile /nix/var/nix/profiles/system'
# nsremote gc     obezglaven        -> ssh obezglaven 'sudo nix-collect-garbage --delete-older-than 30d'
