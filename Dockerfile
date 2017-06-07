FROM alpine:3.5

MAINTAINER Shigure Onishi <iwanomoto@gmail.com>

ENV TERRAFORM_VERSION=0.9.6

RUN apk update && \
    apk add \ 
    ca-certificates \
    unzip \
    wget && \
    wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /cloudwatch_lambda_slack/terraform

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]
