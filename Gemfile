# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '8.0.1'
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '1.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '1.5.9'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '6.6.0'
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '1.3.1'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '2.0.11'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '1.3.4'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '1.4.1'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '3.1.20'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '1.2024.2', platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem 'solid_cable', '3.0.7'
gem 'solid_cache', '1.0.7'
gem 'solid_queue', '1.1.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.18.4', require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem 'kamal', '2.5.0', require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'thruster', '0.1.10', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '1.13.0'
# Client library for easily using the Cloudinary service
gem 'cloudinary', '2.2.0'

# A set of common locale data and translations to internationalize and/or localize your Rails applications
gem 'rails-i18n', '8.0.1'

# Flexible authentication solution for Rails with Warden
gem 'devise', '4.9.4'
# Translations for the devise gem
gem 'devise-i18n', '1.12.1'
# Simple authorization solution for Rails
gem 'cancancan', '3.6.1'

# Allows the records of a ActiveRecord model to be organized in a tree structure
gem 'ancestry', '4.3.3'

# Agnostic pagination in plain ruby
gem 'pagy', '9.3.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '1.10.0', platforms: %i[mri windows], require: 'debug/prelude'

  # Testing framework
  gem 'rspec-rails', '7.1.0'
  # Fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '6.4.4'
  # Library for generating fake data
  gem 'faker', '3.5.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console', '4.2.1'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', '7.0.0', require: false

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '1.71.2', require: false
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', '2.29.1', require: false
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '1.23.1', require: false
  # Code style checking for RSpec files
  gem 'rubocop-rspec', '3.4.0', require: false
  gem 'rubocop-rspec_rails', '2.30.0', require: false
  # Code style checking for factory_bot files
  gem 'rubocop-factory_bot', '2.26.1', require: false
end
