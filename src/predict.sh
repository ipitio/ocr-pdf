#!/bin/bash
# shellcheck disable=SC1091,SC2015

apt_install() {
    # shellcheck disable=SC2068
    apt-get install -yqq python3 python3-pip python3-venv tesseract-ocr poppler-utils git ocrmypdf $@
}

langs=$(echo "$*" | grep -oP '(?<=-l )[^ ]+' | tr '+' '\n' | sed 's/^/tesseract-ocr-/' | sort -u | tr '\n' ' ')
if ! apt_install "$langs"; then
    apt-get update
    apt_install "$langs"
fi

[ -d venv ] || python3 -m venv venv
export OMP_THREAD_LIMIT=1

if [[ -e venv/bin/pip3 ]]; then
    source venv/bin/activate
    ./venv/bin/pip3 install --no-cache-dir -qr requirements.txt
    [ -z "$1" ] || ./venv/bin/python3 main.py "${@:1}"
    deactivate
elif [[ -f /.dockerenv ]]; then
    [[ ":$PATH:" == *":/root/.local/bin:"* ]] || export PATH=$PATH:/root/.local/bin
    /usr/bin/pip3 install --user --break-system-packages --no-cache-dir -qr requirements.txt
    [ -z "$1" ] || /usr/bin/python3 main.py "${@:1}"
fi
