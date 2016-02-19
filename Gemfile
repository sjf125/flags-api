source 'https://rubygems.org'
ruby '2.2.4'

gem 'rails', '~> 4.2.5'
gem 'rails-api'
gem 'active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'pg'
gem 'bcrypt', '~> 3.1.7'

group :production do
  gem 'rails_12factor', '~> 0.0.3'
end

group :development, :test do
  gem 'pry', '~> 0.10'
  gem 'byebug', '~> 8.0'
  gem 'pry-byebug', '~> 3.3.0'
end

group :development do
  gem 'pry-rails', '~> 0.3.4'
  gem 'rb-readline'
  gem 'spring', '~> 1.6.3'
  gem 'spring-commands-rspec', '~> 1.0.4'
end

group :test do
  gem 'rspec-rails', '~> 3.4.2'
  gem 'rspec', '~> 3.4.0'
end
