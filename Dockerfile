FROM leplusorg/aws-cli:latest
ARG POSTGRES_VERSION

USER default

RUN yum install -y gzip libreadline glib* lz4-libs 

WORKDIR /scripts
COPY install-pg-dump.sh .
RUN "/scripts/install-pg-dump.sh"

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
