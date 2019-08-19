FROM ruby:2.5.3-slim

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
EXPOSE 3000
# Install dependencies

CMD /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
