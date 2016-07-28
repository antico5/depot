source 'https://rubygems.org'


# Rails
gem 'rails', github: 'rails/rails'

# Database
gem 'sqlite3', group: :development
gem 'pg'

# App server
gem 'puma', '~> 3.0'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'slim-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# Utilities
gem 'figaro'

# Encryption
gem 'bcrypt', '~> 3.1.7'

group :development do
  # Debugging
  gem 'pry'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  # Deployment gems
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
