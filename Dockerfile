FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get -y install imagemagick
RUN mkdir /baseball
WORKDIR /baseball
ADD Gemfile /baseball/Gemfile
ADD Gemfile.lock /baseball/Gemfile.lock
RUN bundle install
ADD . /baseball
