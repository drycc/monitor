FROM grafana/grafana:7.3.4
USER root
COPY . /
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl \
    && curl -fsSL -o /usr/share/grafana/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/share/grafana/envtpl \
	&& chmod +x /usr/share/grafana/start-grafana \
	&& chmod 644 /usr/share/grafana/grafana.ini.tpl \
	&& chmod +x /usr/share/grafana/entrypoint.sh

WORKDIR /usr/share/grafana
ENTRYPOINT ["/usr/share/grafana/entrypoint.sh"]
CMD ["./start-grafana"]
EXPOSE 3000
