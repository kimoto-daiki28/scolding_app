source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'config'
gem 'dotenv-rails'
gem 'whenever', require: false

# Assets
gem 'sass-rails', '>= 6'
gem 'bootstrap', '4.6.0'
gem 'font-awesome-sass'
gem 'jquery-rails'

# UI/UX
gem 'rails-i18n'
gem 'slim-rails'
gem 'kaminari'
gem 'gretel'

# draper
gem 'draper', github: 'drapergem/draper'

# Authentication
gem 'omniauth-line'

# File Attached
gem 'mini_magick', '>= 4.9.5'
gem 'carrierwave'

# Model
gem 'enum_help'

# Filter
gem 'ransack'
gem 'seed-fu'
gem 'faker'

# LineBot
gem 'line-bot-api'
gem 'httpclient'

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-request_describer'
  gem 'factory_bot_rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_best_practices', require: false
  gem 'slim_lint', require: false
  gem 'scss_lint', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
