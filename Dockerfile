ARG NFT_BUILD

FROM ${NFT_BUILD} AS NFT_BUILD
FROM lnattrass/alpine-base:latest

# Manual build of nft with --json suport
COPY --from=NFT_BUILD /root/packages/src/x86_64/*.apk /tmp/packages/
COPY --from=NFT_BUILD /root/.abuild/*.pub /etc/apk/keys/

RUN apk add --no-cache --update \
      /tmp/packages/* \
      bash \
      jq \
      python3 \
      py3-yaml \
      py3-jinja2 \
      py3-requests \
      ca-certificates \
      conntrack-tools \
      iproute2 \
      iproute2-doc \
      man \
      keepalived \
      curl \
      dhcp \
      dhcpcd \
      dhcrelay \
      tcpdump \
      vim \
      whois \
      wget \
      mtr \
      socat \
      arping \
      darkhttpd \
      less 

RUN \
    # nftables_exporter
    wget -O /usr/bin/nftables_collector https://raw.githubusercontent.com/lnattrass/prometheus-nftables-collector/master/collector.py \
    && chmod +x /usr/bin/nftables_collector \
    # zerotier
    && wget -O /usr/bin/zerotier-one.gz https://download.zerotier.com/dist/static-binaries/zerotier-one.x86_64.gz \
    && gzip -d /usr/bin/zerotier-one.gz && chmod +x /usr/bin/zerotier-one \
    && ln -sf /usr/bin/zerotier-one /usr/bin/zerotier-cli 

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

# Install components:
ADD tree/ /

