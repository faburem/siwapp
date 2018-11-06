FROM alpine:latest
MAINTAINER Fabian Kromer <fabian@kromit.at>

COPY ./Gemfile /app/
COPY ./Gemfile.lock /app/
WORKDIR /app

# Update and install base packages
RUN apk update && apk upgrade && apk add curl wget bash build-base nodejs libxml2-dev libxslt-dev libffi-dev qt-webkit qt-dev postgresql-dev ruby ruby-dev ruby-bundler && bundle config build.nokogiri --use-system-libraries && bundle install && apk del curl build-base libxml2-dev libxslt-dev libffi-dev qt-dev postgresql-dev ruby-dev && rm -rf /var/cache/apk/*

# Copy project src to container
#COPY ./Gemfile /app/
#COPY ./Gemfile.lock /app/

# Set /app as workdir
#WORKDIR /app

EXPOSE 3000

# Install dependencies
#RUN bundle config build.nokogiri --use-system-libraries
#RUN bundle install

# cleanup after ourselves
#RUN apk del curl build-base libxml2-dev libxslt-dev libffi-dev qt-dev postgresql-dev ruby-dev
#RUN rm -rf /var/cache/apk/*

COPY . /app/

CMD /bin/sh -c rm -f /app/tmp/pids/server.pid && rails server -p 3000 -b 0.0.0.0
