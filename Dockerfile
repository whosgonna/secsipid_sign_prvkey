FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y gnupg2 curl && \
    curl -k https://deb.kamailio.org/kamailiodebkey.gpg | apt-key add - && \
    echo "deb http://deb.kamailio.org/kamailio60 bookworm main" > /etc/apt/sources.list.d/kamailio.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends awscli jq nano sngrep dnsutils locales kamailio kamailio-redis-modules \
        kamailio-phonenum-modules kamailio-redis-modules kamailio-rabbitmq-modules kamailio-secsipid-modules \
        kamailio-extra-modules kamailio-json-modules kamailio-tls-modules kamailio-utils-modules && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG


ENTRYPOINT ["kamailio"]

CMD ["-ddDDeE"]
