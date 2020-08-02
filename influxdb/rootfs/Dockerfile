FROM alpine:3.12

COPY . /

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl influxdb \
    && curl -SL -o /home/influxdb/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /home/influxdb/envtpl \
	&& mkdir -p /data \
	&& chmod +x /home/influxdb/start-influx

VOLUME /data

WORKDIR /home/influxdb
CMD ["./start-influx"]

# Expose the admin port
EXPOSE 8083
# Expose the ssl http api port
EXPOSE 8084
# Expose the http api port
EXPOSE 8086
