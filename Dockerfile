FROM ruby:3.3.0-slim

RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get install -y libcurl4-openssl-dev shared-mime-info


RUN apt-get install -y build-essential git libpq-dev pkg-config curl libjemalloc2 libvips postgresql-client

# install git
RUN apt-get install -y git

# create a folder /app in the docker container and go into that folder
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock from app root directory into the /app/ folder in the docker container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

ENV RAILS_ENV="production"

# Run bundle install to install gems inside the gemfile
RUN bundle install --without development test

# Create folder for pids
RUN mkdir -p tmp/pids

# Copy the whole app
COPY . /app


# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]