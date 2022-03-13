FROM alpine:3.15 AS base

LABEL Maintainer="github.com/SalvadorCodes"

ARG BaseLib=https://raw.githubusercontent.com/d-libre/base-sh/main/script/base.sh
ARG LIB=/usr/local/lib
ARG BIN=/usr/local/bin

ADD ${BaseLib}              ${LIB}/base/
ADD script/                 ${LIB}/gget/
ADD docker/entrypoint.sh    /usr/bin/entrypoint

RUN apk add --no-cache bash \
    && rm -rf /usr/local/share \
    # Add permissions to imported base lib
    && chmod 755 ${LIB}/base/base.sh \
    # Symlink from $libs to $bin
    && for lib in base gget; \
    do { ln -s ../lib/${lib}/${lib}.sh ${BIN}/${lib}; } done

WORKDIR /var/files

ENTRYPOINT [ "entrypoint" ]
