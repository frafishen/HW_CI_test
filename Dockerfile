# Use an official Python runtime as a parent image
FROM python:3.10.11-bullseye as base

# Set the working directory
ENV WORKDIR /srv/HW_CI_test
WORKDIR ${WORKDIR}

# Set the PYTHONPATH to include the 'src' directory
ENV PYTHONPATH="${WORKDIR}/src"

# Install necessary system dependencies
RUN apt-get update
RUN apt-get install -y wget unzip
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${WORKDIR}
ADD . ${WORKDIR}

RUN pip install -r requirements.txt
