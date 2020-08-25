FROM alpine:3.12

COPY . /

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl influxdb \
    && curl -SL -o /home/influxdb/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /home/influxdb/envtpl \
	&& mkdir -p /data \
	&& chmod +x /home/influxdb/start-influx

VOLUME /data

WORKDIR /home/influxdb
CMD ["./start-influx"]

# Expose the ssl http api port
EXPOSE 8084
# Expose the http api port
EXPOSE 8086
