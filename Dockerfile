FROM ruby:3.0.4

RUN groupadd -r app && useradd -r -g app app

RUN apt-get update && apt-get install -y \
  build-essential \
  default-mysql-client

RUN mkdir /blogS
WORKDIR /blog

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN chown -R app:app /blog

USER app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

