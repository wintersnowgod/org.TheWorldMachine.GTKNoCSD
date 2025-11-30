#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"

for file in org.TheWorldMachine.GTKNoCSD*.yml; do
    echo -e "\nProcessing: $file"

    version=$(grep 'runtime-version:' "$file" \
      | sed -E 's/.*runtime-version:[[:space:]]*"?([^"]*)"?/\1/')

    echo -e "Version: $version\n"

    flatpak-builder \
        "Build-${version}/" \
        --repo="org.TheWorldMachine.GTKNoCSD-${version}" \
        "$file" \
        --force-clean \
        --user \
        --install-deps-from=flathub

    mkdir -p ./org.gnome.Platform/${version}
    cp ./Build-${version}/files/usr/lib/libgtk-nocsd.so ./org.gnome.Platform/${version}/
    rm -rf ./.flatpak-builder ./Build-${version} ./org.TheWorldMachine.GTKNoCSD-${version}
done

echo -e "\nDone!\n"
