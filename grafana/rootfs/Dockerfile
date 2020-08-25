FROM alpine:3.12

COPY . /

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl grafana \
	&& curl -fsSL -o /usr/share/grafana/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/share/grafana/envtpl \
	&& chmod +x /usr/share/grafana/start-grafana \
	&& chmod 644 /usr/share/grafana/grafana.ini.tpl

WORKDIR /usr/share/grafana
CMD ["./start-grafana"]
EXPOSE 3000
