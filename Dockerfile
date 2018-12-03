FROM elixir:1.6.6-slim

MAINTAINER SalesLoft

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get -y install openssl locales locales-all git

# Install hex
RUN local.hex --force
RUN local.rebar --force

# Copy Mix Files & Install
COPY mix.* ./
RUN mix do deps.get, deps.compile

COPY . ./
