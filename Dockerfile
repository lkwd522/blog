FROM ruby:3.0.4

# Установка зависимостей
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  default-mysql-client

# Создание директории приложения
RUN mkdir /blog
WORKDIR /blog

# Установка гемов
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копирование кода приложения
COPY . .

# Копирование файла development.log
COPY log/development.log /blog/log/development.log

#RUN bundle exec rails db:migrate RAILS_ENV=development
# Запуск сервера приложения
CMD ["rails", "server", "-b", "0.0.0.0"]

