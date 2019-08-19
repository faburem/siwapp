FROM ruby:2.4.3-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY . /app/
WORKDIR /app

RUN apt-get update -qq && \
        apt-get install -y --no-install-recommends \
        build-essential \
        nodejs \
        libpq-dev \
        libqt5webkit5-dev \
        qt5-default xvfb \
        && bundle install && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
        apt-get -yf remove build-essential libqt5webkit5-dev && apt-get autoremove -yf

# Set /app as workdir
WORKDIR /app

EXPOSE 3000

CMD /bin/sh -c rm -f /app/tmp/pids/server.pid && rails server -p 3000 -b 0.0.0.0
