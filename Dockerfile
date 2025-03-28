FROM ruby:3.3.4

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  nodejs \
  yarn \
  curl

# 作業ディレクトリ作成
WORKDIR /app

# Gemfileをコピーしてbundle install
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# その他のファイルをコピー
COPY . /app

# エントリポイントスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート開放
EXPOSE 4000

# サーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
