FROM lwieske/java-8:server-jre-8u121-slim

COPY minecraft /minecraft

ARG SPIGOT_VERSION=latest

RUN apk update && apk add rsync
RUN apk add --no-cache --virtual=buildtools git wget bash && \
    mkdir /spigot-build && cd /spigot-build && \
    wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
    bash -c "java -jar BuildTools.jar --rev ${SPIGOT_VERSION}" && \
    mv /spigot-build/spigot*.jar /minecraft && \
    cd /minecraft && \
    ln -s spigot*.jar spigot.jar && \
    rm -rf /spigot-build /root/.m2 && \
    apk del buildtools && \
    rm -f /var/cache/apk/*
RUN addgroup -S minecraft && \
    adduser -S -G minecraft -h /minecraft -s /bin/ash minecraft && \
    chown -R minecraft /minecraft && \
    chgrp -R minecraft /minecraft

USER minecraft

ENV MINECRAFT_EULA=false

VOLUME /minecraft
WORKDIR /minecraft

CMD ./start.sh
