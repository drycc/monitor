FROM alpine:3.12

COPY . /

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update bash fontconfig curl telegraf \
    && curl -fSL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl \
    && curl -fSL -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 \
    && chmod +x /usr/bin/jq

CMD ["/start-telegraf"]
