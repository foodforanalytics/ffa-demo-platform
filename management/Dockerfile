FROM ubuntu:20.04

ENV AWS_ACCESS_KEY_ID=mock
ENV AWS_SECRET_ACCESS_KEY=mock
ENV AWS_DEFAULT_REGION=eu-west-1
ENV AWS_DEFAULT_OUTPUT=json

RUN apt update \
&& apt install -y curl xz-utils unzip \
&& apt clean \
&& rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm aws -r \
    && rm awscliv2.zip \
    && cd /

