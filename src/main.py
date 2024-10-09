import os
import sys
from pathlib import Path

import fitz  # PyMuPDF
import pytesseract
from joblib import Parallel, delayed
from pdf2image import convert_from_path


def process_pdfs(base: Path = Path(".")):
    """
    Process all PDF files in the "todo" directory and save the OCR results in the "done" directory.

    :param base: The base directory containing the "todo" and "done" directories.
    """
    base.mkdir(exist_ok=True, parents=True)
    (base / "todo").mkdir(exist_ok=True, parents=True)
    (base / "done").mkdir(exist_ok=True, parents=True)

    def predict(input_file: Path, output_file: Path):
        relative_path = input_file.relative_to(base / "todo")
        print(f"Processing {relative_path}...")

        # Create a PDF file to store the OCR results
        doc = fitz.open()
        print(f"Created new PDF file: {output_file}")
        # Perform OCR on the images
        for image in convert_from_path(input_file, dpi=300, fmt="jpeg"):
            prediction = pytesseract.image_to_pdf_or_hocr(image, extension="pdf")
            print("Extracted text from image")
            doc.insert_pdf(fitz.open("pdf", prediction))
            print("Inserted text into PDF")

        # Save the OCR results to a new PDF file
        doc.save(output_file, garbage=4, deflate=True)
        doc.close()
        print(f"Saved OCR results to {output_file}")
        input_file.unlink()
        print(f"Processed {relative_path}")

    # parallel:
    Parallel(n_jobs=-1)(
        delayed(predict)(Path(root) / file, Path(root.replace("todo", "done")) / file)
        for root, _, files in os.walk(base / "todo")
        for file in files
        if file.lower().endswith(".pdf")
    )

    # sequential:
    # for root, _, files in os.walk(base / "todo"):
    #    for file in files:
    #        if file.lower().endswith(".pdf"):
    #            input_file = Path(root) / file
    #            output_file = Path(root.replace("todo", "done")) / file
    #            predict(input_file, output_file)


if __name__ == "__main__":
    process_pdfs(Path(sys.argv[1]))
