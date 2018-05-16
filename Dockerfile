FROM alpine:edge

RUN set -x \
 && addgroup -S stunnel \
 && adduser -S -G stunnel stunnel \
 && apk add --update --no-cache \
        ca-certificates \
        gettext \
        libintl \
        openssl \
        stunnel \
 && cp -v /usr/bin/envsubst /usr/local/bin/ \
 && apk del --purge \
        gettext \
 && apk --no-network info openssl \
 && apk --no-network info stunnel
COPY *.template /srv/stunnel/
COPY stunnel.sh /srv/

RUN set -x \
 && chmod +x /srv/stunnel.sh \
 && mkdir -p /var/run/stunnel /var/log/stunnel \
 && chown -vR stunnel:stunnel /var/run/stunnel /var/log/stunnel \
 && mv -v /etc/stunnel/stunnel.conf /etc/stunnel/stunnel.conf.original

ENTRYPOINT ["/srv/stunnel.sh"]
CMD ["stunnel"]

LABEL org.label-schema.name="ilijaz/stunnel-sni" \
      org.label-schema.description="TLS for HTTP clients" \
      org.label-schema.url="https://github.com/ilijaz/stunnel-sni" \
      org.label-schema.usage="https://github.com/ilijaz/stunnel-sni/blob/master/README.md" \
      org.label-schema.vcs-url="https://github.com/ilijaz/stunnel-sni" \
      org.label-schema.vendor="Ilya Zubakin - mailto:i.zubakin@intexco.org, https://github.com/ilijaz" \
      org.label-schema.schema-version="1.0"

