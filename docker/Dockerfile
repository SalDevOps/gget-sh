FROM alpine:3.15 AS base

ARG BaseLib=https://raw.githubusercontent.com/d-libre/base-sh/main/script/base.sh

ADD ${BaseLib}              /local/lib/base/
ADD script/                 /local/lib/gget/
ADD docker/entrypoint.sh    /local/bin/entrypoint

RUN cd /usr/local/bin \
    && ln -s ../lib/gget/gget.sh gget \
    && ln -s ../lib/base/base.sh base

FROM base AS final

LABEL Maintainer="github.com/SalvadorCodes"

RUN apk add --no-cache bash

COPY --from=base /local/ /usr/local/

WORKDIR /target

ENTRYPOINT [ "entrypoint" ]

CMD bash
