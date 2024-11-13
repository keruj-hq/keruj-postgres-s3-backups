FROM amazon/aws-cli:latest
ARG POSTGRES_VERSION

RUN dnf upgrade -y --releasever=2023.6.20241010
RUN yum update -y \
    && yum install -y gzip

WORKDIR /scripts
COPY install-pg-dump.sh .
RUN "/scripts/install-pg-dump.sh"

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
