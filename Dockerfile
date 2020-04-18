FROM tundrasoft/alpine-base
LABEL maintainer="Abhinav A V<abhai2k@gmail.com>"

ENV USERNAME=""
ENV PASSWORD=""
# ENV PUID=1000
# ENV PGID=1000

RUN apk add --upgrade --no-cache curl \ 
  tar \
  unzip \
  transmission-daemon

# Configure S6
ADD /rootfs /

# Install Themes
RUN echo "*** Installing Combustion ***" \
  && curl -o /tmp/combustion.zip -L "https://github.com/Secretmapper/combustion/archive/release.zip" \
  && unzip /tmp/combustion.zip -d / \
  && mkdir -p /tmp/twctemp \
  && echo "** Installing TWC ***" \
  && TWCVERSION=$(curl -sX GET "https://api.github.com/repos/ronggang/transmission-web-control/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') \
  && curl -o /tmp/twc.tar.gz -L "https://github.com/ronggang/transmission-web-control/archive/${TWCVERSION}.tar.gz" \
  && tar xf /tmp/twc.tar.gz -C /tmp/twctemp --strip-components=1 \
  && mv /tmp/twctemp/src /transmission-web-control \
  && echo "** Install Kettu ***" \
  && mkdir -p /kettu \
  && curl -o /tmp/kettu.tar.gz -L "https://github.com/endor/kettu/archive/master.tar.gz" \
  && tar xf /tmp/kettu.tar.gz -C /kettu --strip-components=1 \
  && echo "*** Cleanup ***" \
  && rm -rf /tmp/*

RUN apk del curl \
  tar \
  unzip

RUN rm -rf /var/cache/apk/* \
  /root/.cache \
  /tmp/*

# Make directories
RUN mkdir -p /downloads/incomplete \
  /downloads/complete \
  /downloads/watch

# Volumes
VOLUME [ "/downloads", "/config" ]
# Ports
EXPOSE 9091 51413/tcp 51413/udp
