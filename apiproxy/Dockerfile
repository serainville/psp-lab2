FROM alpine

RUN apk add -U curl privoxy jq busybox-extras bind-tools mtr vim tcptraceroute
RUN mv /etc/privoxy/templates /etc/privoxy-templates && \
    rm -rf /var/cache/apk/* /etc/privoxy/* && \
    mv /etc/privoxy-templates /etc/privoxy/templates && \
    chown -R 10000:10000 /etc/privoxy

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.4/main' >> /etc/apk/repositories && \
    apk update && \
    apk del curl && \
    apk del git && \
    apk del libcurl && \
    apk del libssh2 && \
    apk add libssh2==1.7.0-r0 --no-cache && \
    apk add libcurl --no-cache && \
    apk add curl --no-cache && \
    apk add git --no-cache && \
    rm -rf /var/cache/apk/*

ADD --chown=10000:10000 cfg/privoxy.conf \
    /etc/privoxy/privoxy.conf

ADD --chown=10000:10000 cfg/k8s-only.action \
    /etc/privoxy/k8s-only.action

ADD --chown=10000:10000 cfg/k8s-rewrite-external.filter \
    /etc/privoxy/k8s-rewrite-external.filter

ADD --chown=10000:10000 proxy.sh /

EXPOSE 8118/tcp

RUN chown -Rv 10000:10000 /etc/privoxy
RUN ls -l /etc
RUN ls -l /etc/privoxy
RUN ls -l /etc/privoxy/templates

USER 10000

ENTRYPOINT ["./proxy.sh"]

