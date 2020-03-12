source 'https://rubygems.org'

gem 'bcrypt', '3.1.12'
gem 'bootstrap', '~>4.3.1'
gem 'carrierwave', '1.2.2'
gem 'coffee-rails', '4.2.2'
gem 'font-awesome-sass', '~> 5.4.1'
gem 'jbuilder',     '2.7.0'
gem 'jquery-rails', '4.3.1'
gem 'kaminari'
gem 'mini_magick', '4.7.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '3.9.1'
gem 'rails', '5.1.6'
gem 'rails-i18n'
gem 'ransack'
gem 'sass-rails',   '5.0.6'
gem 'turbolinks',   '5.0.1'
gem 'uglifier',     '3.2.0'

group :development, :test do
  gem 'byebug', '9.0.6', platform: :mri
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'rspec-rails', '~> 3.8.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console',           '3.5.1'
end

group :test do
  gem 'capybara', '~> 2.15.4'
  gem 'guard', '2.13.0'
  gem 'guard-minitest', '2.4.4'
  gem 'launchy'
  gem 'minitest', '5.10.3'
  gem 'minitest-reporters', '1.1.14'
  gem 'rails-controller-testing', '1.0.2'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'webdrivers'
end

group :production do
  gem 'fog-aws'
  gem 'unicorn'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
