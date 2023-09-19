source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Redis adapter to run Action Cable in production
gem "redis"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# an approach for pagination [https://github.com/ddnexus/pagy]
gem 'pagy'

gem "ruby-openai"

# Simple, efficient background processing using Redis.
# https://github.com/sidekiq/sidekiq
gem "sidekiq", "~> 7.0.9"

if ENV.fetch("RAILS_ENV", "development") == "development"
  gem 'tailsman', path: '../../../tailsman'
else
  gem 'tailsman', "~> 0.2.0", github: 'zeekerpro/tailsman'
end

group :development, :test do
  gem "debug"
  gem "solargraph-rails", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  # gem "web-console"
  gem 'annotate'
end

gem "dockerfile-rails", ">= 1.2", :group => :development

gem "pundit", "~> 2.3"

gem "foreman"
