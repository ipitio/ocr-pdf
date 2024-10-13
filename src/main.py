"""
This script OCRs files
"""

import os
import sys
from pathlib import Path

import pymupdf
import pytesseract
from joblib import Parallel, delayed
from natsort import natsorted, ns
from pdf2image import convert_from_path
from PIL import Image


def predict(base: Path, input_file: Path) -> None:
    """
    Predicts the text in the input file and saves it to the output file

    Args:
        base (Path): The base directory
        input_file (Path): The input file
    """
    relative_path = input_file.relative_to(base / "todo")
    output_file = base / "done" / relative_path.with_suffix(".pdf")

    if str(input_file).lower().endswith(".pdf"):
        pages = convert_from_path(input_file, fmt="jpeg")
    else:
        try:
            pages = [Image.open(input_file)]
        except Exception:
            return

    print(f"Processing {relative_path}...")
    doc = pymupdf.open()

    for page in pages:
        doc.insert_pdf(pymupdf.open("pdf", pytesseract.image_to_pdf_or_hocr(page)))

    if not output_file.parent.exists():
        output_file.parent.mkdir(exist_ok=True, parents=True)

    doc.save(output_file, garbage=4, deflate=True)
    doc.close()

    try:
        input_file.unlink()
    except Exception:
        pass

    print(f"Processed {relative_path}")


if __name__ == "__main__":
    pdfs = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    pdfs.mkdir(exist_ok=True, parents=True)
    (pdfs / "todo").mkdir(exist_ok=True, parents=True)
    (pdfs / "done").mkdir(exist_ok=True, parents=True)

    Parallel(n_jobs=-1)(
        delayed(predict)(pdfs, Path(root) / file)
        for root, _, files in os.walk(pdfs / "todo")
        for file in files
    )

    # Remove empty directories
    for root, _, files in os.walk(pdfs / "todo"):
        if not files:
            try:
                os.rmdir(root)
            except Exception:
                pass

    # Merge PDFs
    for root, _, files in os.walk(pdfs / "done"):
        proot = Path(root)
        if proot == pdfs / "done":
            continue

        pdf_list = [
            pymupdf.open(proot / file)
            for file in files
            if file.lower().endswith(".pdf")
        ]
        if not pdf_list:
            continue

        merged = pymupdf.open()
        for pdf in natsorted(pdf_list, key=lambda x: x.name, alg=ns.IGNORECASE):
            merged.insert_pdf(pdf)

        merged.save(Path(root + ".pdf"), garbage=4, deflate=True)
        merged.close()

        for pdf in pdf_list:
            pdf.close()

    print("Done")
