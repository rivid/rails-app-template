

gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'haml-rails'
gem 'hamlit'

gem 'devise'
gem 'omniauth'

gem 'friendly_id'
gem 'kaminari'

gem 'select2-rails'
gem 'carrierwave'
gem 'mini_magick'

gem 'hiredis'
gem 'redis'

gem 'sinatra', require: false
gem 'sidekiq'


gem 'annotate', '~> 2.6.6'

gem 'bcrypt'
gem 'enumerize'

gem 'gon'

gem 'meta-tags'
gem 'sitemap_generator'

gem 'puma'
#deployment
gem 'mina', require: false
gem 'mina-multistage', require: false
gem 'mina-sidekiq', require: false
gem 'mina-puma', require: false



gem_group :development do
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-migrate'
  gem 'guard-annotate'
  gem 'quiet_assets'
  gem 'rails_layout'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman', require: false
end

gem_group :development, :test do
  gem 'byebug'
  gem 'pry'
  gem 'web-console', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring'
end

gem_group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'ffaker'
  gem 'webmock'
  gem 'shoulda'
end




after_bundle do
  inject_into_file 'config/application.rb', after: "# -- all .rb files in that directory are automatically loaded.\n" do <<-'RUBY'
    config.generators.template_engine = :haml
    config.i18n.default_locale = "zh-CN"
  RUBY
  end

  inject_into_file 'config/environments/development.rb', after: "# -- all .rb files in that directory are automatically loaded.\n" do <<-'RUBY'
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  rake "db:migrate"

  generate "rspec:install"

  generate "devise:install"
  generate "devise", "user"


  rake "db:migrate"

  #init guard config
  run "guard init"
  run "mina init"

  #fetch default .gitignore
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/config/.gitignore -O .gitignore"

  
  File.open('app/assets/javascripts/application.js', 'a') { |f| f.write("\n//= require bootstrap-sprockets")}


  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"

end
