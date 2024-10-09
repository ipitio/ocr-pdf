#!/bin/bash
# shellcheck disable=SC1091

set -Eeuo pipefail
declare -r pdf_dir="${1:-.}"
export OMP_THREAD_LIMIT=1

python3 -m venv venv
source venv/bin/activate

./venv/bin/pip3 install -r requirements.txt
./venv/bin/python3 ./main.py "$pdf_dir"

deactivate
[[ "$pdf_dir" == "." ]] || rm -rf venv
