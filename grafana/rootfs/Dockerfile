FROM docker.io/drycc/go-dev:latest AS go-dev


FROM docker.io/grafana/grafana:7.3.4
USER root
COPY . /
COPY --from=go-dev /bin/envtpl /usr/share/grafana/envtpl
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl \
    && chmod +x /usr/share/grafana/start-grafana \
    && chmod 644 /usr/share/grafana/grafana.ini.tpl \
    && chmod +x /usr/share/grafana/entrypoint.sh

WORKDIR /usr/share/grafana
ENTRYPOINT ["/usr/share/grafana/entrypoint.sh"]
CMD ["./start-grafana"]
EXPOSE 3000
