#既存のプロジェクトのrubyのバージョンを指定
FROM ruby:2.6.3 

#パッケージの取得
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    nodejs  \
    mariadb-client  \
    build-essential  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/rails/myapp

COPY Gemfile /var/www/rails/myapp/Gemfile
COPY Gemfile.lock /var/www/rails/myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install 

COPY . /var/www/rails/myapp