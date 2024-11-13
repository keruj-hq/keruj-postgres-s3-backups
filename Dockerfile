FROM amazon/aws-cli:latest
ARG POSTGRES_VERSION

RUN yum install -y yum install -y https://download.postgresql.org/pub/repos/yum/17/redhat/rhel-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum install -y gzip postgresql17

WORKDIR /scripts
#COPY install-pg-dump.sh .
#RUN "/scripts/install-pg-dump.sh"

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
