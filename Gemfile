source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jwt'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'sqlite3'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_rewinder'
  gem 'factory_bot_rails'
  gem 'json_spec', require: false
  gem 'rspec-rails'
  gem 'timecop', require: false
  gem 'webmock', require: false
end
