FROM fedora:latest AS build

RUN dnf upgrade --refresh -y && \
    dnf install cargo openssl-devel wget jq -y 

RUN export TAGNAME=$(wget -q -O- https://api.github.com/repos/vi/websocat/releases/latest | jq -r '.tag_name')
    wget https://codeload.github.com/vi/websocat/tar.gz/$TAGNAME -O- | tar xz && \
    cd websocat-$TAGNAME && \
    cargo build --features=ssl --release --target-dir ..


FROM fedora:latest

COPY --from=build release/websocat /usr/bin/

RUN dnf upgrade --refresh -y && \
    dnf install curl wget -y && \
    dnf clean all -y
