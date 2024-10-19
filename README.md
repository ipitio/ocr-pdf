<div align="center">

[![logo](public/wide.webp)](https://github.com/ipitio/ocr-pdf)

# ocr2pdf

**OCRmyPDF and Merge it**

---

[![downloads](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fipitio.github.io%2Fbackage%2Fipitio%2Focr-pdf%2Focr-pdf.json&query=%24.downloads&logo=github&logoColor=959da5&labelColor=333a41&label=pulls)](https://github.com/ipitio/ocr-pdf/pkgs/container/ocr-pdf) [![build](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml/badge.svg)](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml)

</div>

Convert images and scans to searchable and selectable (and merged) PDFs! The core logic resides in a Python script that you could run yourself, if you really wanted to. It extracts all the files from `todo`, transforms them with Tesseract via [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF), and loads them into `done`. Files in subfolders will be merged in alphabetical order, but will still be available individually.

I recommend you use either:

- The Bash script, which runs the Python script
- The Docker image, which runs the Bash script
- A Google Colab or GitHub Actions server, both of which run the Docker image

Read on to find out which is best for you! In any case, the Bash script is, or must be, called like so:

```bash
bash /path/to/predict.sh /folder/containing/todo/ [OCRmyPDF options]
```

For more information, see the [OCRmyPDF documentation](https://ocrmypdf.readthedocs.io/en/latest).

## Fast Start

It's as easy as 1, 2, 3! Get up and going in no time with these options:

### Cloud: Google Colab Notebook

Are you on mobile or simply want an easy and seamless experience?

1. Open [Colab](https://colab.research.google.com/github/ipitio/ocr-pdf/blob/master/colab.ipynb) in your browser
2. Follow the instructions in the notebook
3. Find the OCR'd files in your [Drive](https://drive.google.com/drive/my-drive)`/ocr-pdf`

To add OCRmyPDF options, append them to the `run` command in the code cell.

### Self-hosted: Prebuilt Docker Image

If you want to skip building an image, just use mine:

1. Install Docker, such as with Docker Desktop
2. Make a new `pdf` folder and put your files in `pdf/todo`
3. Run the following command from `pdf/..` to convert the files and move them into `pdf/done`

```bash
docker run --rm \
    -v ./pdf:/app/pdf \
    ghcr.io/ipitio/ocr-pdf \
    bash predict.sh pdf [OCRmyPDF options]
```

## Quick Start

It's still easy as 1, 2, 3! You'll find the OCR'd files in `pdf/done`.

1. First (fork and) clone this repo
2. `cd` into it and put your files in `pdf/todo`
3. Complete one of the following:

### Cloud: GitHub Actions Workflow

If you made a fork and cloned it, Git is your best friend!

```bash
git add .
git commit -m "add files"
git push
# wait for the magic to happen
git pull
```

To add OCRmyPDF options, edit the command in the `predict.yml` file before committing.

### Self-hosted

#### Build Docker Image

If you aren't on Linux, or want to avoid polluting your system, use Docker Compose (which is included with Docker Desktop):

```bash
docker compose up
```

To add OCRmyPDF options, edit the command in the `compose.yml` file.

#### Use Bare Metal

Are you on Linux and want to make the most out of it?

```bash
bash src/predict.sh pdf [OCRmyPDF options]
```
