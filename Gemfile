source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'rack-coffee', :require => 'rack/coffee'
gem 'padrino-sprockets', :require => 'padrino/sprockets', :git => 'https://github.com/nightsailer/padrino-sprockets.git'
gem 'bcrypt'
gem 'sass'
gem 'haml'
gem 'thin'
gem 'sequel'
gem 'automatic-client'
gem 'omniauth-automatic'
gem 'omniauth'
gem 'coffee-script'
gem 'sidekiq'
gem 'activesupport'
gem 'active_model_serializers', '~> 0.8.0'
group :development do 
  gem "sqlite3"
end

group :production do 
  gem 'pg'
end

# Test requirements

# Padrino Stable Gem
gem 'padrino', '0.12.5'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.5'
# end
