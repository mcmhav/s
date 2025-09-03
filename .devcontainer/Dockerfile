# FROM ubuntu:jammy
FROM public.ecr.aws/docker/library/ubuntu:noble
# RUN apk add git util-linux
# RUN apt-get update && apt-get install -y git util-linux curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        locales \
        git \
        util-linux \
        curl

RUN locale-gen en_US.UTF-8

