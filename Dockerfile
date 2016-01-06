FROM webhippie/steamcmd:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

WORKDIR /game
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/s6-svscan", "/etc/s6"]

RUN apt-get update && \
  apt-get install -y \
    libcurl4-gnutls-dev:i386 && \
  apt-get \
    clean

EXPOSE 10999/udp 10888/udp
VOLUME ["/storage"]
ADD rootfs /

RUN chown -R steam:steam \
  /game

RUN /usr/bin/steamcmd \
  +runscript /game/params.txt
