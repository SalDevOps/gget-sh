ARG BaseLib=https://raw.githubusercontent.com/SalDevOps/base-sh/main/script/base.sh
# -- BEGIN --
FROM gget/test-base:alpine-curl AS base-alpine-curl
ARG BaseLib
ADD ${BaseLib} /usr/local/bin/base
ADD script/* /usr/local/lib/gget/
RUN ln -s ../lib/gget/gget.sh /usr/local/bin/gget

FROM gget/test-base:alpine AS bare-alpine-wget
ARG BaseLib
ADD ${BaseLib} /usr/local/bin/base
ADD script/* /usr/local/lib/gget/
RUN ln -s ../lib/gget/gget.sh /usr/local/bin/gget

FROM gget/test-base:centos7 AS base-centos-curl
ARG BaseLib
ADD ${BaseLib} /usr/local/bin/base
ADD script/* /usr/local/lib/gget/
RUN ln -s ../lib/gget/gget.sh /usr/local/bin/gget

FROM gget/test-base:alpine-nolib AS bare-minimal
ARG BaseLib
ADD ${BaseLib} /usr/local/bin/base
ADD script/* /usr/local/lib/gget/
RUN ln -s ../lib/gget/gget.sh /usr/local/bin/gget


# -- TESTS --
# Works in Alpine with curl
FROM base-alpine-curl AS smoke-test-alpine-curl
RUN gget --prefix test-repo- -u docker-tests -o /test re-sources/public

# Works in plain Alpine (no curl but wget)
FROM bare-alpine-wget AS smoke-test-alpine-wget
RUN gget --prefix test-repo- -u docker-tests -o /test re-sources/public

# Works in CentOS-7 (with wget)
FROM base-centos-curl AS smoke-test-centos-curl
RUN gget --prefix test-repo- -u docker-tests -o /test re-sources/public

# Access to Private Repository
FROM base-alpine-curl AS private-repo-access
ADD tests/owner-user.key /run/secrets/token
RUN gget --prefix test-repo- -u owner-user --secret token -o /test re-sources/private

# Should fail if neither curl nor wget available
FROM bare-minimal AS with-no-libraries
RUN gget re-sources/test-repo-public || touch /test/OK

FROM bare-alpine-wget AS disposed-env-variables
RUN gget -o /test re-sources/test-repo-public \
    && env | grep gget || { echo "No gget variables found"; }


# -- END --
# Merge output to enforce execution of all stages
FROM scratch AS results

COPY --from=smoke-test-alpine-curl  /test/OK /dev/null
COPY --from=smoke-test-alpine-wget  /test/OK /dev/null
COPY --from=smoke-test-centos-curl  /test/OK /dev/null
COPY --from=private-repo-access     /test/OK /dev/null
COPY --from=with-no-libraries       /test/OK /dev/null
COPY --from=disposed-env-variables  /test/OK /dev/null
# Done!