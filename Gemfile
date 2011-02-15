source 'http://rubygems.org'

gem 'rails', '3.0.4'

gem 'sqlite3-ruby', :require => 'sqlite3'

gem 'thin'
gem 'SystemTimer'
gem 'engineyard'

group :development do
	gem 'ruby-debug'
	gem "nifty-generators"
	gem 'ohm'
end

group :staging, :production do
	gem 'ohm', '0.0.35'
end

group :test do
	gem 'cucumber-rails'
	gem 'capybara'
	gem 'database_cleaner'
	gem 'rspec-rails'
	gem 'shoulda-matchers'
	gem 'mocha'
	gem 'factory_girl'
end