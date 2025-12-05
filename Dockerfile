# Use Ruby 3.1.4 as base image
FROM ruby:3.1.4

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 (required for Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler -v '2.5.23'

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy package.json and install npm packages
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Precompile assets (optional - can be done at runtime)
# RUN bundle exec rails assets:precompile

# Create directory for pid file
RUN mkdir -p tmp/pids

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh

# Expose port 3000
EXPOSE 3000

# Set entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
