#!/bin/bash

set -e

black_box_single_pdf() {
    \cp -f pdf/todo/example.pdf.bak pdf/todo/example.pdf
    bash predict.sh pdf
    [ ! -f pdf/todo/example.pdf ] || exit 1
    [ -f pdf/done/example.pdf ] || exit 1
    rm -f pdf/done/example.pdf
}

black_box_single_pdf
echo "All tests passed!"
