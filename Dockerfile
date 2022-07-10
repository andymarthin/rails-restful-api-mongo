# Ruby image
FROM ruby:3.1.1-slim-buster
# Define our app root path
ENV APP_HOME /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev

# Set the working directory to /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy the current directory contents into the container at our app path
COPY . $APP_HOME
# Copy Gemfiles over to the app
COPY Gemfile* $APP_HOME/
RUN bundle install
# Clean up after gems are installed
RUN rm $APP_HOME/Gemfile*

# Clean up uncessary data generated during the setup
RUN apt-get remove -y wget \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/cache \
    /var/lib/log \
    /usr/share/doc \
    /usr/share/locale

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]