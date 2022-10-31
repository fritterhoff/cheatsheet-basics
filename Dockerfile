FROM alpine:3.16.2@sha256:1304f174557314a7ed9eddb4eab12fed12cb0cd9809e4c28f29af86979a3c870 as alpine-glibc

ENV LANG=C.UTF-8
# Here we install GNU libc (aka glibc) and set C.UTF-8 locale as default.
RUN apk add --no-cache make gcc musl-dev git 

FROM alpine-glibc as latex-slim
COPY tex-profile.txt /tmp/

# set up packages
RUN apk add --no-cache wget perl xz && \
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    install-tl-20*/install-tl --profile=/tmp/tex-profile.txt && \
    rm -rf install-tl-* && \
    rm -f /usr/local/texlive/tlpkg/texlive.tlpdb.*

ENV PATH=/usr/local/texlive/bin/x86_64-linuxmusl:$PATH

RUN tlmgr update --self && \
    rm -f /usr/local/texlive/tlpkg/texlive.tlpdb.*

FROM latex-slim

RUN tlmgr install titlesec koma-script listingsutf8 biber csquotes luainputenc fontspec luatexbase collection-latex synctex catchfile latex-bin hyphen-german babel-german breakurl minted fvextra etoolbox fancyvrb upquote lineno ifplatform xstring xkeyval framed float tcolorbox pgf xcolor environ trimspaces caption cite ieeetran tex-gyre times psnfss algorithms l3kernel l3packages listings lm adjustbox collectbox parskip biblatex logreq makecell siunitx cleveref microtype && \
    apk add --no-cache python3 git fontconfig && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install pygments && \
    rm -f /usr/local/texlive/tlpkg/texlive.tlpdb.*

COPY tex /usr/local/texlive/texmf-local/tex
RUN wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip && \
    unzip Fira_Code_v6.2.zip -d Fira_Code_v6.2 && \
    mkdir -p /usr/share/fonts/truetype/FiraCode && \
    cp Fira_Code_v6.2/ttf/*.ttf /usr/share/fonts/truetype/FiraCode && \
    rm -rf Fira_Code_v6.2* && \
    fc-cache -fv
RUN mktexlsr