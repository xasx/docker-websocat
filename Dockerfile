FROM fedora:latest

RUN dnf upgrade --refresh -y && \
    dnf copr enable atim/websocat -y && \
    dnf install websocat curl wget -y
