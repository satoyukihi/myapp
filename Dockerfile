#既存のプロジェクトのrubyのバージョンを指定
FROM ruby:2.6.3 

#パッケージの取得
ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    nodejs  \
    mariadb-client  \
    build-essential  \
    wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/rails/myapp

COPY Gemfile /var/www/rails/myapp/Gemfile
COPY Gemfile.lock /var/www/rails/myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install -j4

COPY . /var/www/rails/myapp