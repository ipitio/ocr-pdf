# OCR your PDF files

With the help of Bash, Python, git, GitHub Actions, and machine learning. Concepts include scripting, virtual environments, package management, image processing, OCR, version control, and CI/CD.

## Quick start

It's as easy as 1, 2, 3!

### Manually

1. Put your PDF files without searchable text in the `todo` folder.
2. Go to the directory this file is in and run `bash main.sh`.
3. Find the OCR'd PDF files in the `done` folder.

### With git and GitHub

1. Put your PDF files without searchable text in the `todo` folder.
2. Commit and push these files so that GitHub can do the above step 2 for you.
3. Pull the next change to get the OCR'd PDF files in the `done` folder.

## How it works

The shell script is only used to create a venv, install the required packages, and run the cross-platform Python script. The Python script is the one that does the actual OCR work using the `pytesseract` library, which is a Python wrapper for Google's LSTM-based Tesseract OCR engine. The script reads the PDF files in the `todo` folder, extracts the images from them, OCRs the images, and creates new PDF files with the OCR'd text. The new PDF files are saved in the `done` folder.
