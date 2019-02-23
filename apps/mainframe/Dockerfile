FROM elixir:1.8.1-alpine as builder

RUN apk add --no-cache \
    gcc \
    git \
    make \
    musl-dev

RUN mix local.rebar --force && \
    mix local.hex --force

WORKDIR /app

ENV MIX_ENV=prod
