source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.3'

gem 'devise'

gem 'twitter-bootstrap-rails', '~> 3.2', '>= 3.2.2'

gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'listen', '>= 3.0.5', '< 3.2'
end


