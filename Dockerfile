# Use an official Python runtime as the base image
FROM python:3.9-slim 
#The slim image omits many non-essential packages that aren’t needed to run Python itself, making the image significantly smaller than the full python:3.9 image.

# Set the working directory in the container
WORKDIR /app

# install required packages for system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt #Using --no-cache-dir helps reduce the final image size by avoiding unnecessary temporary files.

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]

