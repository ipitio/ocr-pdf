#!/bin/bash
# shellcheck disable=SC1091,SC2015

apt_install() {
    # shellcheck disable=SC2068
    apt-get install -y python3 python3-pip python3-venv tesseract-ocr poppler-utils git ocrmypdf $@
}

main() {
    find . -name requirements.txt -exec pip3 install --user --root-user-action ignore --break-system-packages --no-cache-dir -r {} \;
    [ -z "$1" ] || find . -name main.py -exec python3 {} "${@:1}" \;
}

langs=$(echo "$*" | grep -oP '(?<=-l )[^ ]+' | tr '+' '\n' | sed 's/^/tesseract-ocr-/' | sort -u | tr '\n' ' ')
if ! apt_install "$langs" 2>/dev/null; then
    apt-get update
    apt_install "$langs"
fi

[ -d venv ] || python3 -m venv venv
export OMP_THREAD_LIMIT=1

if [[ -e venv/bin/pip3 ]]; then
    source venv/bin/activate
    main "${@}"
    deactivate
elif [[ -f /.dockerenv ]]; then
    [[ ":$PATH:" == *":/root/.local/bin:"* ]] || export PATH=$PATH:/root/.local/bin
    main "${@}"
fi
