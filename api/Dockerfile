FROM ruby:2.7.1

ENV LANG=C.UTF-8 \
  STDOUT_SYNC=true \
  BUNDLE_PATH=/usr/local/bundle

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/

RUN bundle install -j8

COPY . .

ENTRYPOINT [ "bundle", "exec" ]
CMD [ "rails", "s", "-p", "3000", "-b", "0.0.0.0" ]
