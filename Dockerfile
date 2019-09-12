FROM lnattrass/alpine-base:latest

RUN apk add --no-cache --update \
      bash \
      ca-certificates \
      nftables \
      conntrack-tools \
      iproute2 \
      keepalived \
      curl \
      dhcp \
      dhcpcd \
      dhcrelay \
      ifupdown \
      tcpdump \
      vim \
      whois \
      wget \
      mtr \
      socat \
      less 

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories \
    && apk add --no-cache --update bird@testing \
    # yq for bash-inline-yaml stuff:
    && wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/2.4.0/yq_linux_amd64" \
    && chmod +x /usr/local/bin/yq \
    # confd for templating:
    && wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    # zerotier for vpn
    && wget -O /usr/local/bin/zerotier-one.gz https://download.zerotier.com/dist/static-binaries/zerotier-one.x86_64.gz\
    && gzip -d /usr/local/bin/zerotier-one.gz && chmod +x /usr/local/bin/zerotier-one \
    && ln -sf /usr/local/bin/zerotier-one /usr/local/bin/zerotier-cli

# Install components:
ADD tree/ /
