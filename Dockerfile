FROM alpine:latest as alpine-glibc

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

RUN tlmgr install titlesec koma-script listingsutf8 biber csquotes collection-latex latexmk synctex texcount latexindent catchfile latex-bin collection-langgerman babel-german breakurl minted fvextra etoolbox fancyvrb upquote lineno ifplatform xstring xkeyval framed float tcolorbox pgf xcolor environ trimspaces l3kernel l3packages listings lm adjustbox collectbox parskip biblatex logreq makecell siunitx cleveref && \
    apk add --no-cache python3 git && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install pygments && \
    rm -f /usr/local/texlive/tlpkg/texlive.tlpdb.*

COPY tex /usr/local/texlive/texmf-local/tex
RUN mktexlsr