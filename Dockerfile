FROM ruby:2.4.3-alpine

COPY . /app/
WORKDIR /app

RUN apk --update --no-cache add curl wget bash build-base nodejs libgcc libstdc++ libx11 glib libxrender libxext libintl libcrypto1.0 libssl1.0 ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family libxml2-dev libxslt-dev libffi-dev qt-webkit qt-dev postgresql-dev && bundle config build.nokogiri --use-system-libraries && bundle install && apk del build-base wget curl

EXPOSE 3000

CMD /bin/sh -c rm -f /app/tmp/pids/server.pid && rails server -p 3000 -b 0.0.0.0
