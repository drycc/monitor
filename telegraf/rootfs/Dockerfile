FROM docker.io/drycc/go-dev:latest AS go-dev


FROM docker.io/library/telegraf:1.21.2

COPY . /
COPY --from=go-dev /bin/envtpl /usr/bin/envtpl

RUN chown -R telegraf /home/telegraf/ \
  && apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc
WORKDIR /home/telegraf
CMD ["/home/telegraf/start-telegraf"]
