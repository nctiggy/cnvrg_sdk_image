FROM python:3.5-alpine

LABEL maintainer="craig.smith@cnvrg.io"

RUN apk add --no-cache --virtual .build-deps \
            git \
            openssh \
            build-base \
            libffi-dev \
            openssl-dev

ARG SSH_PRIVATE_KEY

RUN mkdir /root/.ssh && \
            #echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && \
            #chmod 400 /root/.ssh/id_ed25519 && \
            touch /root/.ssh/known_hosts && \
            ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN --mount=type=ssh,id=github git clone git@github.com:AccessibleAI/cnvrg-sdk.git
            #chmod 600 /root/.ssh/id_ed25519 && \
            #rm /root/.ssh/id_ed25519

WORKDIR cnvrg-sdk

RUN pip3 install -r requirements.txt && \
            pip3 install .

#Cleanup the image
WORKDIR /

RUN rm -Rf cnvrg-sdk

RUN apk del .build-deps
