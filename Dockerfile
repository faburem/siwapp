FROM ruby:2.4-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY . /app/
WORKDIR /app

RUN apt-get update -qq && \
	apt-get install -y \
	build-essential \
	nodejs \
	libpq-dev \
	libqt5webkit5-dev \
	qt5-default \
	xvfb && bundle install && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	apt-get remove build-essential

# Copy project src to container
#COPY ./Gemfile /app/
#COPY ./Gemfile.lock /app/

# Set /app as workdir
#WORKDIR /app

EXPOSE 3000

# Install dependencies
#RUN bundle install

#COPY . /app/

CMD /bin/sh -c rm -f /app/tmp/pids/server.pid && rails server -p 3000 -b 0.0.0.0
