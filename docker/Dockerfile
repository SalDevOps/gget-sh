FROM alpine:3.15 AS base

ARG BaseLib=https://raw.githubusercontent.com/d-libre/base-sh/main/script/base.sh

ADD ${BaseLib}              /local/lib/base/
ADD script/                 /local/lib/gget/
ADD docker/entrypoint.sh    /local/bin/entrypoint

RUN chmod 755 /local/lib/base/base.sh \
    && cd /usr/local/bin \
    && for lib in base gget; \
    do { ln -s ../lib/${lib}/${lib}.sh ${lib}; } done


FROM base AS final

LABEL Maintainer="github.com/SalvadorCodes"

RUN apk add --no-cache bash

COPY --from=base /local/ /usr/local/

WORKDIR /target

ENTRYPOINT [ "entrypoint" ]

CMD bash
