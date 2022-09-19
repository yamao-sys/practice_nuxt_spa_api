FROM ruby:2.7.1-alpine

ARG WORKDIR

ENV RUNTIME_PACKAGES="nodejs yarn tzdata git imagemagick mysql-dev" \
    DEV_PACKAGES="build-base curl-dev mysql-client" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies

COPY . .
