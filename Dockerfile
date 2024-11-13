FROM amazon/aws-cli:latest
ARG POSTGRES_VERSION

RUN amazon-linux-extras install postgresql17
RUN yum-config-manager --enable postgresql17


RUN yum install -y gzip postgresql17

WORKDIR /scripts
#COPY install-pg-dump.sh .
#RUN "/scripts/install-pg-dump.sh"

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
