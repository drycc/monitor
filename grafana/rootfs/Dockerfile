FROM docker.io/drycc/base:bullseye

RUN adduser --system \
   --shell /bin/bash \
   --disabled-password \
   --home /usr/share/grafana \
   --group \
   drycc

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
WORKDIR /usr/share/grafana
CMD ["./start-grafana"]
EXPOSE 3000
