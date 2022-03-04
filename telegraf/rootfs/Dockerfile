FROM docker.io/drycc/base:bullseye

ARG DRYCC_UID=1001
ARG DRYCC_GID=1001
ARG DRYCC_HOME_DIR=/home/telegraf

RUN groupadd drycc --gid $DRYCC_GID \
  && useradd drycc -u $DRYCC_UID -g $DRYCC_GID -s /bin/bash -m -d $DRYCC_HOME_DIR

COPY . /
ENV TELEGRAF_VERSION="1.21.3" \
    ENVTPL_VERSION="1.0.0" \
    JQ_VERSION="1.6"

RUN install-stack telegraf $TELEGRAF_VERSION \
  && install-stack envtpl $ENVTPL_VERSION \
  && install-stack jq $JQ_VERSION \
  && rm -rf \
      /usr/share/doc \
      /usr/share/man \
      /usr/share/info \
      /usr/share/locale \
      /var/lib/apt/lists/* \
      /var/log/* \
      /var/cache/debconf/* \
      /etc/systemd \
      /lib/lsb \
      /lib/udev \
      /usr/lib/`echo $(uname -m)`-linux-gnu/gconv/IBM* \
      /usr/lib/`echo $(uname -m)`-linux-gnu/gconv/EBC* \
  && mkdir -p /usr/share/man/man{1..8} \
  && chown -R drycc:drycc $DRYCC_HOME_DIR

USER drycc
WORKDIR $DRYCC_HOME_DIR
CMD ["/home/telegraf/start-telegraf"]
