#!/bin/bash

cd "${0%/*}" || exit 1

# install tesseract
if [[ "$OSTYPE" == "msys" ]]; then
    if ! command -v choco &> /dev/null; then
        echo "Please install Chocolatey (https://chocolatey.org/) and run this script again."
        exit 1
    fi

    choco install tesseract
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew install tesseract
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get install tesseract-ocr
    elif command -v yum &> /dev/null; then
        sudo yum install tesseract
    else
        echo "Could not install tesseract. Please install it manually."
        exit 1
    fi
else
    echo "Could not install tesseract. Please install it manually."
    exit 1
fi

python3 -m venv venv
# shellcheck disable=SC1091
source venv/bin/activate
pip install -r requirements.txt
python main.py "$@" || exit 1
deactivate
rm -rf venv
