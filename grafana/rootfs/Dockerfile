FROM docker.io/drycc/base:bullseye

ARG DRYCC_UID=1001
ARG DRYCC_GID=1001
ARG DRYCC_HOME_DIR=/usr/share/grafana

RUN groupadd drycc --gid $DRYCC_GID \
  && useradd drycc -u $DRYCC_UID -g $DRYCC_GID -s /bin/bash -m -d $DRYCC_HOME_DIR


COPY . /
ENV GRAFANA_VERSION="8.3.6" \
    ENVTPL_VERSION="1.0.0"

RUN install-packages fontconfig curl \
  && install-stack grafana $GRAFANA_VERSION \
  && install-stack envtpl $ENVTPL_VERSION \
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
  && bash -c "mkdir -p /usr/share/man/man{1..8}" \
  && mkdir /var/lib/grafana -p \
  && chown -R drycc:drycc /opt/drycc/grafana /usr/share/grafana /var/lib/grafana \
  && chmod +x /usr/share/grafana/start-grafana \
  && chmod 644 /usr/share/grafana/grafana.ini.tpl \
  && chmod +x /usr/share/grafana/entrypoint.sh

USER drycc
WORKDIR $DRYCC_HOME_DIR
CMD ["./start-grafana"]
EXPOSE 3000
