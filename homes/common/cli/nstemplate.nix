{
  config,
  lib,
  pkgs,
  ...
}:

let
  templatesPath = "$HOME/Desktop/nixos/nixosConfig/templates";

  # ============================================================
  # nstemplate — Project scaffolding from Nix templates
  # ============================================================
  #
  # HOW TO ADD A NEW TEMPLATE:
  #   1.
  #   2. Add it to `templates.nix` outputs (templates.<name> = { ... })
  #

  templates = (import ../../../templates/flake.nix).outputs { self = null; };

  templateNames = lib.attrNames templates.templates;
  templateNamesBash = lib.concatStringsSep " " templateNames;

  nstemplateScript = pkgs.writeShellApplication {
    name = "nstemplate";

    runtimeInputs = [
      pkgs.nix
      pkgs.git
    ];

    text = ''
      usage() {
        echo "nstemplate - Create projects from Nix templates"
        echo ""
        echo "Usage:"
        echo "  nstemplate <template> <name>"
        echo ""
        echo "Templates:"
        for t in ${templateNamesBash}; do
          echo "  $t"
        done
        echo ""
        echo "Examples:"
        echo "  nstemplate go hello-api"
        echo "  nstemplate python scraper"
        exit 1
      }

      [ $# -lt 2 ] && usage

      template="$1"
      name="$2"

      if [ -e "$name" ]; then
        echo "Error: $name already exists"
        exit 1
      fi

      echo "Creating $template project: $name"

      mkdir "$name"
      cd "$name"

      nix flake init -t "${templatesPath}#$template" >/dev/null 2>&1

      # Replace template variables
      find . -type f \
        -not -path './.git/*' \
        -exec sed -i "s/@PROJECT_NAME@/$name/g" {} +

      git init -q -b main
      git add .

      echo "Done! -> cd $name && nix develop"
    '';
  };

  nstemplateCompletion = pkgs.writeTextFile {
    name = "nstemplate-completion";
    destination = "/share/zsh/site-functions/_nstemplate";
    text = ''
      #compdef nstemplate

      _nstemplate() {
        local -a templates

        templates=(${templateNamesBash})

        case $CURRENT in
          2) _describe 'template' templates ;;
          3) _message 'project name' ;;
        esac
      }

      _nstemplate "$@"
    '';
  };
in
{
  home.packages = [
    nstemplateScript
    nstemplateCompletion
  ];
}
