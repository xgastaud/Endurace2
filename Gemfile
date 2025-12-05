source 'https://rubygems.org'
ruby '3.1.4'

gem 'rails', '~> 7.2.2'

# Core dependencies
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.4'
gem 'redis', '~> 5.3'
gem 'bootsnap', require: false

# Authentication & Authorization
gem 'devise', '~> 4.9'
gem 'pundit', '~> 2.3'
gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# File uploads & Assets
gem 'carrierwave', '~> 3.0'
gem 'cloudinary', '~> 2.4'
gem 'image_processing', '~> 1.2'

# Frontend
gem 'vite_rails', '~> 3.0'
gem 'cssbundling-rails', '~> 1.4'
gem 'dartsass-rails', '~> 0.5'

# Utilities
gem 'jbuilder', '~> 2.11'
gem 'geocoder', '~> 1.8'
gem 'kaminari', '~> 1.2'
gem 'pg_search', '~> 2.3'
gem 'acts_as_votable', '~> 0.14.0'

# Configuration
gem 'figaro'

# Admin
# gem 'forest_liana' # Disabled for Rails 7.2 compatibility - needs update

# API
gem 'rack-cors', '~> 2.0'

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.9'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
end
