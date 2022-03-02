FROM docker.io/drycc/base:bullseye

RUN adduser --system \
   --shell /bin/bash \
   --disabled-password \
   --group \
   drycc

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
  && bash -c "mkdir -p /usr/share/man/man{1..8}"

USER drycc
CMD ["/home/telegraf/start-telegraf"]
