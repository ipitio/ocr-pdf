#!/bin/bash
# shellcheck disable=SC1091,SC2015

set -Eeuo pipefail
declare -r pdf_dir="${1:-.}"
#export OMP_THREAD_LIMIT=1

apt-get install -y python3 python3-pip python3-venv tesseract-ocr poppler-utils
python3 -m venv venv

if [[ -f venv/bin/pip3 ]]; then
    source venv/bin/activate
    find . -name requirements.txt -exec ./venv/bin/pip3 install --no-cache-dir -r {} \;
    ./venv/bin/python3 ./main.py "$pdf_dir"
    deactivate
elif [[ -f /.dockerenv ]]; then
    export PATH="$PATH:/root/.local/bin"
    pip3 install -r requirements.txt --user --break-system-packages
    python3 ./main.py "$pdf_dir"
fi
