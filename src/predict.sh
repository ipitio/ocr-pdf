#!/bin/bash
# shellcheck disable=SC1091,SC2015

apt_install() {
    apt-get install -y python3 python3-pip python3-venv tesseract-ocr poppler-utils git
}

if ! apt_install 2>/dev/null; then
    apt-get update
    apt_install
fi

[ -d venv ] || python3 -m venv venv
export OMP_THREAD_LIMIT=1

if [[ -f venv/bin/pip3 ]]; then
    source venv/bin/activate
    find . -name requirements.txt -exec ./venv/bin/pip3 install --no-cache-dir -r {} \;
    [ -z "$1" ] || find . -name main.py -exec ./venv/bin/python3 {} "$1" \;
    deactivate
elif [[ -f /.dockerenv ]]; then
    [[ ":$PATH:" == *":/root/.local/bin:"* ]] || export PATH=$PATH:/root/.local/bin
    pip3 install -r requirements.txt --user --break-system-packages
    [ -z "$1" ] || python3 ./main.py "$1"
fi
