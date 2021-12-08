FROM python:3

LABEL maintainer="craig.smith@cnvrg.io"

COPY requirements.txt ./

RUN pip3 install -r requirements.txt
