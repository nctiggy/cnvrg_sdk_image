FROM python:3.5-alpine

LABEL maintainer="craig.smith@cnvrg.io"

RUN apk add --no-cache --virtual .build-deps \
            git \
            openssh \
            build-base \
            libffi-dev \
            openssl-dev

RUN --mount=type=ssh git clone git@github.com:AccessibleAI/cnvrg-sdk.git

WORKDIR cnvrg-sdk

RUN pip3 install -r requirements.txt && \
            pip3 install .

#Cleanup the image
WORKDIR /

RUN rm -Rf cnvrg-sdk

RUN apk del .build-deps
