FROM ruby:2.4-slim-stretch

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
	apt-get install -y \
	build-essential \
	nodejs \
	libpq-dev \
	libqt5webkit5-dev \
	qt5-default \
	xvfb \
	openssl-devel

# Copy project src to container
COPY ./Gemfile /app/
COPY ./Gemfile.lock /app/

# Set /app as workdir
WORKDIR /app

EXPOSE 3000

# Install dependencies
RUN bundle install

COPY . /app/

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
