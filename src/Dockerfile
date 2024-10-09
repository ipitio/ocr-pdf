# Description: Dockerfile for the OCR PDF program

# Use a Tesseract image instead of building or installing it manually
FROM franky1/tesseract
# install python and a dependency for a dependency
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    poppler-utils
# copy the dependencies file to the working directory
COPY requirements.txt /app/requirements.txt
# set the working directory in the container
WORKDIR /app
# copy the source code
COPY . /app
# run the program
CMD ["bash", "predict.sh"]
