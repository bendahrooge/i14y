# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'i14y'
set :repo_url, 'git@github.com:GSA/i14y.git'
set :rails_env, 'production'
set :deploy_to, '/home/search/i14y'
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets]
set :linked_files, %w[config/newrelic.yml config/secrets.yml config/elasticsearch.yml]

# Default branch is :main
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:app), in: :parallel do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end

after 'deploy:finished'
