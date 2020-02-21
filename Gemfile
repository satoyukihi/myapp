source 'https://rubygems.org'

gem 'rails',        '5.1.6'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'bootstrap','~>4.1.1'
gem 'bcrypt',         '3.1.12'
gem 'rails-i18n'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'kaminari'
gem 'font-awesome-sass', '~> 5.4.1'
gem 'ransack'

group :development, :test do
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails','~> 3.8.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest',                 '5.10.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  gem 'capybara'
  gem 'webdrivers'
  gem 'launchy'
end

group :production do
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]