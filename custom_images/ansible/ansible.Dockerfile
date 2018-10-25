# https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md

FROM alpine

ARG ANSIBLE_VERSION=2.7.0

RUN apk --update add python py-pip gcc python-dev openssl-dev libffi-dev libc-dev make
RUN pip install ansible==${ANSIBLE_VERSION}

ENV ANSIBLE_LOCAL_TEMP=/tmp
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1
