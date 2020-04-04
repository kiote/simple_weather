FROM elixir:1.10-alpine
ENV MIX_ENV=prod TERM=xterm
WORKDIR /opt/app

COPY . .

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

RUN apk update \
    && apk --no-cache --update add git g++ make bash curl openssh \
    && apk add --update alpine-sdk coreutils \
    && mix local.rebar --force \
    && mix local.hex --force \
    && mix do deps.get, deps.compile, compile \
    && MIX_ENV=prod mix release \
    && mv _build/prod/rel/simple_weather /opt/release

ENV SECRET_KEY_BASE=""

FROM alpine:3.9
ENV MIX_ENV=prod REPLACE_OS_VARS=true
WORKDIR /opt/app

RUN apk update && apk --no-cache --update add bash openssl

COPY --from=0 /opt/release .
RUN chmod +x /opt/app/bin/simple_weather
CMD trap 'exit' INT; \
  cd /opt/app && \
  bin/simple_weather foreground
