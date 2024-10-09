# OCR PDF

Make your unsearchable PDFs searchable with the help of automation, virtualization, and a pretrained deep learning model!

The core logic resides in a Python script that gets all the PDFs in `todo`, converts their pages to OCR'd images with Google's LSTM-based OCR engine Tesseract, and combines these into new PDFs in `done`. The Bash script installs the necessary libraries for and runs the Python script in a virtual environment. Docker sets up another virtual environment within which it installs Python, Tesseract, and Poppler and calls the Bash script. The GitHub Actions workflow starts the Docker container in yet a third virtual layer, making use of the cloud.

You choose how much you want to automate and virtualize.

## Fast Start

It's as easy as 1, 2, 3! Get up and going in no time with these options:

### Google Colab

If you want to avoid typing any commands or installing anything on your computer, then...

1. Open [ocr-pdf.ipynb](https://colab.research.google.com/drive/1yss_oypuRisb29_SnqLGgA759slQzNry?usp=sharing) in your browser
2. Click `Runtime > Run all` and follow the instructions
3. Find the OCR'd PDFs in your Google Drive at `ocr-pdf/pdf/done`

### Docker Image

If you want to avoid cloning the repo and building the image, then...

1. Install Docker and Compose, such as with Docker Desktop
2. Create a `./pdf/todo` folder and the `./compose.yml` file with the following content:

```yaml
services:
  ocr-pdf:
    image: ghcr.io/ipitio/ocr-pdf
    volumes:
      - ./pdf/todo:/pdf/todo
      - ./pdf/done:/pdf/done
```

1. Run `docker compose up` to OCR the PDFs and move them into `./pdf/done`

## Quick Start

It's as easy as 1, 2, 3, 4, 5! Once you complete the following steps, you'll find the OCR'd PDFs in `pdf/done`.

1. First (fork and) clone this repo
2. `cd` into it and put your PDFs in `pdf/todo`
3. Choose one of the following options:

### Bare Metal

If you are on Linux and want to make the most out of it, then...

4. Install Python 3, Tesseract, and Poppler
5. Run `bash src/predict.sh pdf`

### Docker Build

If you aren't on Linux, or just want to avoid installing those dependencies, then...

4. Install Docker and Compose, such as with Docker Desktop
5. Run `docker compose up`

### GitHub Actions

If you cloned a fork and want to avoid downloading or installing anything else, then...

4. Push the bad PDFs to GitHub
5. Pull the good ones from it

```bash
git add -- *.pdf
git commit -m "Add PDFs"
git push
# wait for the magic to happen
git pull
```
