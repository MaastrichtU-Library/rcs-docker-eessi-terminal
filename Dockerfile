FROM ubuntu:24.04

COPY --from=docker.io/tsl0922/ttyd:latest /usr/bin/ttyd /usr/bin/ttyd

RUN apt-get update && apt-get install -y --no-install-recommends \
      tmux git openssh-client less vim nano curl wget ca-certificates \
      procps bash-completion \
    && rm -rf /var/lib/apt/lists/*

RUN chgrp 0 /etc/passwd /etc/group && chmod g=u /etc/passwd /etc/group

RUN mkdir -p /data/persistent \
    && chgrp -R 0 /data/persistent && chmod -R g=u /data/persistent

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh

ENV HOME=/data/persistent
WORKDIR /data/persistent
USER 1001
EXPOSE 7681
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
