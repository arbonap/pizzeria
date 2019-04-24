source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '4.2.8'

gem 'active_model_serializers'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
group :production do
  gem 'pg', '~> 0.20'
  gem 'puma'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'web-console', '~> 2.0', group: :development

group :test do
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem "rspec-rails"
  gem 'factory_bot_rails'
end
