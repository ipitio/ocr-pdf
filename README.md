<div align="center">

[![logo](public/wide.webp)](https://github.com/ipitio/ocr-pdf)

# ocr2pdf

**Convert images or scans to searchable PDFs!**

---

[![downloads](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fipitio.github.io%2Fbackage%2Fipitio%2Focr-pdf%2Focr-pdf.json&query=%24.downloads&logo=github&logoColor=959da5&labelColor=333a41&label=pulls)](https://github.com/arevindh/pihole-speedtest/pkgs/container/pihole-speedtest) [![build](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml/badge.svg)](https://github.com/ipitio/ocr-pdf/actions/workflows/publish.yml)

</div>

You can run this in your browser, on your computer, or somewhere in between, depending how much you want to automate and virtualize. The core logic resides in a Python script that you could run yourself, if you really wanted to. It extracts all the files from `todo`, transforms their pages with a pretrained LSTM RNN, and loads them into `done`. Files in subfolders will be merged in alphabetical order, but will still be available individually.

I recommend you use either:

- The Bash script, which runs the Python script
- The Docker image, which runs the Bash script
- A Google Colab or GitHub Actions server, both of which run the Docker container

Read on to find out which is best for you!

## Fast Start

It's as easy as 1, 2, 3! Get up and going in no time with these options:

### Cloud: Google Colab Notebook

Are you on mobile or simply want an easy and seamless experience?

1. Open [the app](https://colab.research.google.com/drive/1yss_oypuRisb29_SnqLGgA759slQzNry) in your browser
2. Run the cell to convert your files and/or zipped folders
3. Find the OCR'd files in your [Google Drive](https://drive.google.com/drive/my-drive)`/ocr-pdf`

### Self-hosted: Prebuilt Docker Image

If you want to skip building an image, just use mine:

1. Install Docker and Compose, such as with Docker Desktop
2. Enter a new folder, add the file below, and put your files in `./pdf/todo`
3. Run the following command to OCR the files and move them to `./pdf/done`

```yaml
# compose.yml
services:
    predict:
        container_name: ocr2pdf
        image: ghcr.io/ipitio/ocr-pdf:latest
        command: bash predict.sh pdf
        volumes:
            - ./pdf:/app/pdf
```

```bash
docker compose up
```

## Quick Start

It's still easy as 1, 2, 3! You'll find the OCR'd files in `pdf/done`.

1. First (fork and) clone this repo
2. `cd` into it and put your files in `pdf/todo`
3. Complete one of the following:

### Cloud: GitHub Actions Workflow

If you made a fork and cloned it, Git is your best friend!

```bash
git add pdf/*
git commit -m "add files"
git push
# wait for the magic to happen
git pull
```

### Self-hosted

#### Build Docker Image

If you aren't on Linux, or want to avoid polluting your system, use Docker Compose:

```bash
docker compose up
```

#### Use Bare Metal

Are you on Linux and want to make the most out of it?

```bash
bash src/predict.sh pdf
```
