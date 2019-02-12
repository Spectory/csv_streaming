source 'https://rubygems.org'
ruby '2.5.0'
gem 'dotenv-rails', :groups => [:development, :test]
gem 'rails', '>= 5.1.2'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'yui-compressor'
gem 'ejs'
gem 'colorize'
gem 'pg'
gem 'rack-cors'
# gem 'turbolinks'  * use only with round trip apps. single page apps dont need that.
# gem 'aws-sdk'     * amazon access
# gem 'clockwork'   * if you need to schedule tasks with less the 10 min intervals
# gem 'dalli'       * memory cache
# gem 'pundit'      * authorization system
# gem 'bcrypt' * secure passwords

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
  gem 'jasmine-rails'
  gem 'guard-shell'
  gem 'scss_lint', require: false
  gem 'rubocop'
  gem 'awesome_print'
  # gem 'pry'
  gem 'byebug'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'libnotify' #if /linux/ =~ RUBY_PLATFORM
  gem 'growl' #if /darwin/ =~ RUBY_PLATFORM
  gem 'database_cleaner'
  gem 'simplecov', require: false, group: :test
end

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
  gem 'newrelic_rpm'
end
