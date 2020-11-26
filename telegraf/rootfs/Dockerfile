FROM telegraf:1.16.2

COPY . /

RUN curl -fSL -o /usr/bin/envtpl https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 \
	&& chmod +x /usr/bin/envtpl \
    && curl -fSL -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 \
    && chmod +x /usr/bin/jq

CMD ["/start-telegraf"]
