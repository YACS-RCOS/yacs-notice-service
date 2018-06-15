FROM ruby:2.5.1

RUN apt-get update && apt-get install -qq -y build-essential nodejs wget postgresql-client --fix-missing --no-install-recommends

ENV INSTALL_PATH /usr/src/app/
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock $INSTALL_PATH
RUN bundle install

COPY . $INSTALL_PATH
CMD "rails server --binding 0.0.0.0 --port 4900"
