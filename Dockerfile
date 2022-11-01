FROM alpine:3.16.2@sha256:1304f174557314a7ed9eddb4eab12fed12cb0cd9809e4c28f29af86979a3c870
RUN apk update
RUN apk add --no-cache texlive python3 make ghostscript git biber
RUN rm -rf /tmp/*
RUN wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip && \
    unzip Fira_Code_v6.2.zip -d Fira_Code_v6.2 && \
    mkdir -p /usr/share/fonts/truetype/FiraCode && \
    cp Fira_Code_v6.2/ttf/*.ttf /usr/share/fonts/truetype/FiraCode && \
    rm -rf Fira_Code_v6.2* && \
    fc-cache -fv
RUN mktexlsr
WORKDIR /data