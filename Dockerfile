FROM ruby:2.4-alpine

COPY . /app/
WORKDIR /app

RUN apk update && apk add curl wget bash build-base nodejs libxml2-dev libxslt-dev libffi-dev qt-webkit qt-dev postgresql-dev && bundle config build.nokogiri --use-system-libraries && bundle install && apk del build-base wget curl && rm -rf /var/cache/apk/*

EXPOSE 3000

CMD /bin/sh -c rm -f /app/tmp/pids/server.pid && rails server -p 3000 -b 0.0.0.0
