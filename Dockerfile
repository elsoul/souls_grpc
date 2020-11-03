FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client redis-server cron

USER root

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle
COPY . /myapp

RUN chmod 755 /myapp/public
RUN chmod 777 -R /myapp/tmp
RUN whenever --update-crontab

EXPOSE 3000
CMD ["foreman", "start"]