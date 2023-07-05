FROM ruby:3.0.4

RUN groupadd -r app && useradd -r -g app app
# Установка зависимостей
RUN apt-get update && apt-get install -y \
  build-essential \
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

# Установка прав для пользователя app
RUN chown -R app:app /blog
RUN chmod 0664 /blog/log/development.log

# Создание пустого файла server.pid
RUN touch /blog/tmp/pids/server.pid
RUN chown app:app /blog/tmp/pids/server.pid

# Установка разрешений на каталог tmp/pids
RUN chmod 0777 /blog/tmp/pids

# Установка разрешений на каталог tmp/cache/assets
RUN chmod -R 0777 /blog/tmp/cache/assets

USER app

# Предварительная компиляция ассетов (если нужно)

# Запуск сервера приложения
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

