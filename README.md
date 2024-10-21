<div align="center">

[![logo](public/wide.webp)](https://github.com/ipitio/ocr-pdf)

# ocr2pdf

**OCRmyPDF and Merge it**

---

[![build](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml/badge.svg)](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml) [![downloads](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fipitio.github.io%2Fbackage%2Fipitio%2Focr-pdf%2Focr-pdf.json&query=%24.downloads&logo=github&logoColor=959da5&labelColor=333a41&label=pulls)](https://github.com/ipitio/ocr-pdf/pkgs/container/ocr-pdf) [![size](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fipitio.github.io%2Fbackage%2Fipitio%2Focr-pdf%2Focr-pdf.json&query=%24.size&logo=github&logoColor=959da5&label=size&labelColor=333a41&color=indigo)](https://github.com/arevindh/backage/pkgs/container/backage) [![latest](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fipitio.github.io%2Fbackage%2Fipitio%2Focr-pdf%2Focr-pdf.xml&query=%2Fbkg%2Fversion%5B.%2Flatest%5B.%3D%22true%22%5D%5D%2Ftags%5B.!%3D%22latest%22%5D&logo=github&logoColor=959da5&label=latest&labelColor=333a41&color=darkgreen)](https://github.com/arevindh/backage/pkgs/container/backage)

</div>

Convert images and scans to searchable and selectable (and merged) PDFs! The core logic resides in a Python script that extracts all the files from `todo`, transforms them with Tesseract via [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF), and loads them into `done`.

> [!NOTE]
> Files in subfolders will be merged in alphabetical order, but will still be available individually.

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

1. Run the [Colab](https://colab.research.google.com/github/ipitio/ocr-pdf/blob/master/colab.ipynb) cell in your browser
2. Follow the prompts to upload your files
3. Find the OCR'd files in your [Drive](https://drive.google.com/drive/my-drive)`/ocr-pdf`

To add OCRmyPDF options, append them to the `run` command.

### Self-hosted: Prebuilt Docker Image

If you want to skip building an image, just use mine:

1. Install Docker, such as with Docker Desktop
2. Make a new `pdf` folder and put your files in `pdf/todo`
3. Run the following command from the parent of `pdf` to convert the files and move them into `pdf/done`

```bash
docker run --rm \
    -v ./pdf:/app/pdf \
    ghcr.io/ipitio/ocr-pdf \
    bash predict.sh pdf [OCRmyPDF options]
```

## Quick Start

It's still easy as 1, 2, 3! You'll find the OCR'd files in `pdf/done`.

1. Fork and clone this repo
2. `cd` into it and put your files in `pdf/todo`
3. Complete one of the following:

### Cloud: GitHub Actions Workflow

Enable Actions and push your files:

```bash
git add .
git commit -m "add files"
git push
# wait for the magic to happen
git pull
```

To add OCRmyPDF options, edit the command in the `predict.yml` file before committing.

### Self-hosted

#### Docker Compose Service

If you want to avoid polluting your system, use Docker Compose (which is included with Docker Desktop):

```bash
docker compose up
```

To add OCRmyPDF options, edit the command in the `compose.yml` file.

#### Bash Install Script

Do want to make the most out of your hardware?

```bash
bash src/predict.sh pdf [OCRmyPDF options]
```
