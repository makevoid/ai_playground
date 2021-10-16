FROM ruby:3.0.0-rc1-buster

# RUN apk add --update --no-cache linux-headers && \
  # rm -rf /tmp/* /var/cache/apk/*

WORKDIR /app

COPY Gemfile* ./
COPY .bundle/* .bundle/
RUN cp .bundle/config_production .bundle/config
RUN bundle

# bundle text2speech dependency
COPY lib/wavenet/Gemfile* ./lib/wavenet/
COPY lib/wavenet/.bundle/* ./lib/wavenet/.bundle/
RUN cp ./lib/wavenet/.bundle/config_production ./lib/wavenet/.bundle/config
RUN cd lib/wavenet && BUNDLE_GEMFILE=./Gemfile bundle

COPY . ./

EXPOSE 3000

CMD "./cmd.sh"
