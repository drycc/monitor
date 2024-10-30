ARG CODENAME
FROM registry.drycc.cc/drycc/base:${CODENAME}

ENV DRYCC_UID=1001 \
  DRYCC_GID=1001 \
  DRYCC_HOME_DIR=/home/telegraf \
  MC_VERSION="2024.10.08.09.37.26" \
  TELEGRAF_VERSION="1.32.2" \
  ENVTPL_VERSION="1.0.0" \
  JQ_VERSION="1.7.1"

RUN groupadd drycc --gid ${DRYCC_GID} \
  && useradd drycc -u ${DRYCC_UID} -g ${DRYCC_GID} -s /bin/bash -m -d ${DRYCC_HOME_DIR}

COPY . /

RUN install-stack mc ${MC_VERSION} \
  && install-stack telegraf ${TELEGRAF_VERSION} \
  && install-stack envtpl ${ENVTPL_VERSION} \
  && install-stack jq ${JQ_VERSION} \
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
  && chown -R ${DRYCC_UID}:${DRYCC_GID} ${DRYCC_HOME_DIR}

USER ${DRYCC_UID}
WORKDIR ${DRYCC_HOME_DIR}
CMD ["/home/telegraf/start-telegraf"]
