#!/usr/bin/env bash


###
DEBUG=false  # show full debug info
APPLY=true # actually update inputs (true = run nix flake lock)
###

set -e
flake="flake.nix"

# Detect inputs PS no ffing idea how to use regex and tf is this Kirby
inputs=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url' "$flake" | sed 's/\.url//')

# Strict tags
locked=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url.*#\s*--lock;' "$flake" | sed 's/\.url.*//')
auto=$(grep -oP '^\s*([A-Za-z0-9_-]+)\.url.*#\s*--auto;' "$flake" | sed 's/\.url.*//')

### DEBUG ###
if [ "$DEBUG" = true ]; then
    echo "DEBUG MODE ENABLED"
    echo
    echo "All inputs found:"
    printf "  • %s\n" $inputs
    echo
    echo "Inputs tagged --lock:"
    if [ -z "$locked" ]; then echo "  • none"; else printf "  • %s\n" $locked; fi
    echo
    echo "Inputs tagged --auto:"
    if [ -z "$auto" ]; then echo "  • none"; else printf "  • %s\n" $auto; fi
    echo "----------------------------------------"
fi


echo "❄️  Update:"
for name in $inputs; do
    if echo "$locked" | grep -qw "$name"; then
        echo "⛔ Skip (locked): $name"
        continue
    fi

    if [ "$APPLY" = true ]; then
        echo "🔄 Updating: $name"
        nix flake update "$name"
    else
        echo "✅ Would update: $name"
    fi
done

echo
if [ "$APPLY" = true ]; then
    echo "✅ APPLY MODE: updates applied"
else
    echo "❗❗❗ DRY RUN — no changes made❗❗❗"
fi
