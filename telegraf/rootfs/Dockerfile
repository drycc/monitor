FROM docker.io/drycc/go-dev:latest AS go-dev


FROM docker.io/library/telegraf:1.16.2

COPY . /
COPY --from=go-dev /bin/envtpl /usr/bin/envtpl

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

CMD ["/start-telegraf"]
