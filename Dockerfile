FROM amazon/aws-cli:latest
ARG POSTGRES_VERSION

USER default

RUN yum install -y gzip postgresql17

WORKDIR /scripts
COPY install-pg-dump.sh .
RUN "/scripts/install-pg-dump.sh"

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
