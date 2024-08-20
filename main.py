import os
from pathlib import Path
import pytesseract
from pdf2image import convert_from_path
import fitz  # PyMuPDF

# Ensure Tesseract is in the PATH or specify its location explicitly
pytesseract.pytesseract.tesseract_cmd = (
    r"/usr/local/bin/tesseract"  # Update this path if necessary
)


def ocr_pdf(input_path: Path, output_path: Path):
    """_summary_

    Args:
        input_path (Path): _description_
        output_path (Path): _description_
    """
    # Convert PDF to images
    images = convert_from_path(input_path, dpi=300)

    # Create a new PDF document
    doc = fitz.open()

    for image in images:
        # Perform OCR on the image
        text = pytesseract.image_to_string(image)

        # Create a new PDF page with the image and text overlay
        pdf_page = doc.new_page(width=image.width, height=image.height)
        pdf_page.insert_image(pdf_page.rect, stream=image.convert("RGB").tobytes())
        pdf_page.insert_text((0, 0), text, fontsize=12, color=(0, 0, 0))

    # Save the new PDF to the output path
    doc.save(output_path)


def process_pdfs(base: Path):
    """_summary_

    Args:
        base (Path): _description_
    """
    for root, _, files in os.walk(base):
        for file in files:
            if file.lower().endswith(".pdf"):
                input_file = Path(root) / file
                relative_path = input_file.relative_to(base)
                output_file = base / "done" / relative_path

                # Ensure the output directory exists
                output_file.parent.mkdir(parents=True, exist_ok=True)

                print(f"Processing {input_file}...")
                ocr_pdf(input_file, output_file)
                print(f"Saved OCR processed file to {output_file}")


if __name__ == "__main__":
    # Change to the script's directory
    script_dir = Path(__file__).resolve().parent
    os.chdir(script_dir)

    # Define base directory for input PDFs and output location
    base_dir = script_dir / "todo"

    # Process all PDFs
    process_pdfs(base_dir)
