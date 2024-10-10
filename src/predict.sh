#!/bin/bash
# shellcheck disable=SC1091

set -Eeuo pipefail
declare -r pdf_dir="${1:-pdf}"
export OMP_THREAD_LIMIT=1
python3 -m venv venv

if [[ -f venv/bin/pip3 ]]; then
    source venv/bin/activate

    ./venv/bin/pip3 install -r requirements.txt
    ./venv/bin/python3 ./main.py "$pdf_dir"

    deactivate
    [[ "$pdf_dir" == "pdf" ]] || rm -rf venv
elif [[ -f /.dockerenv ]]; then
    export PATH="$PATH:/root/.local/bin"
    pip3 install -r requirements.txt --user --break-system-packages
    python3 ./main.py "$pdf_dir"
    rm -rf venv
fi
