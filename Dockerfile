FROM python:3.5

LABEL maintainer="craig.smith@cnvrg.io"

RUN mkdir /root/.ssh

RUN echo $SSH_PRIVATE_KEY > /root/.ssh/id_ed25519

RUN chmod 400 /root/.ssh/id_ed25519

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone git@github.com:AccessibleAI/cnvrg-sdk.git

WORKDIR cnvrg-sdk

RUN pip3 install -r requirements.txt && \
            pip3 install .

WORKDIR /

RUN rm -Rf cnvrg-sdk
RUN chmod 600 /root/.ssh/id_ed25519 && \
            rm /root/.ssh/id_ed25519
