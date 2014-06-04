source 'http://rubygems.org'

# Globals dependencies
gem 'rails', '3.2.13'
gem 'migrant'
gem 'activeadmin'
gem 'meta_search',    '>= 1.1.0.pre'

gem 'airbrake'
gem 'carrierwave'

# Production environment dependencies
group :production, :staging do
  gem 'mysql2'
end

# Assets dependencies
group :assets do
  gem 'jquery-rails', '2.1.4'
  gem 'coffee-rails',   '~> 3.2'
  gem 'sass-rails',   '~> 3.2'
  gem 'bootstrap-sass', '~> 2.3.2.0'
  gem 'uglifier',     '>= 1.0.3'
  gem 'therubyracer'

  gem 'compass-rails'
end

# Development environment dependencies (also needed by test environement)
group :development, :test do
  gem 'sqlite3'
  gem 'debugger'

  gem 'rspec-rails'
  gem 'spork', '~> 0.9.0.rc'

  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'

  gem 'pry'
  gem 'pry-remote'
  gem 'hirb-unicode'

  gem 'simplecov',    require: false
end

# Dependencies should be load only in development environment
group :development do
  gem 'capistrano'
end

# Guard dependencies
group :guard do
  gem 'guard'

  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-rails-assets'
  gem 'guard-pow'
  gem 'guard-livereload'

  gem 'rb-fsevent', require: false
  gem 'ruby_gntp',  require: false
end

