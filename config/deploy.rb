# config valid only for current version of Capistrano
lock '3.4.0'

set :pty, true
set :rvm_ruby_string, 'ruby-2.3.0'
set :rvm_type, :user

set :application, 'app_test'
set :repo_url, 'git@github.com:michael-miao91/app_test.git'

# Default branch is :master
set :branch, 'cap_dev'
# Default value for :scm is :git
set :scm, :git
set :user, 'ruby'

# Default deploy_to directory is /var/www/my_app_name
# 部署目录
set :deploy_to, "/home/rails/#{fetch(:application)}"
# 链接的文件
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')
# 链接的目录s
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'pids', 'tmp/sockets')

# set :git_shallow_clone, 1

# role :web, 'rails'
# role :app, 'rails'
# role :db,  'rails', primary: true
# role :queue, 'rails'

# 可以看到bundle install的输出
set :bundle_flags, ''


# task :link_shared, roles: :web do
#   run "mkdir -p #{shared_path}/log"
#   run "mkdir -p #{shared_path}/pids"
#   run "mkdir -p #{shared_path}/assets"
#   run "mkdir -p #{shared_path}/system"
#   run "mkdir -p #{shared_path}/cache"
#   run "ln -sf #{shared_path}/system #{current_path}/public/system"
#   run "ln -sf #{shared_path}/assets #{current_path}/public/assets"
#   run "ln -sf #{shared_path}/config/*.yml #{current_path}/config/"
#   run "ln -sf #{shared_path}/config/initializers/secret_token.rb #{current_path}/config/initializers"
#   run "ln -sf #{shared_path}/pids #{current_path}/tmp/"
#   run "ln -sf #{shared_path}/cache #{current_path}/tmp/"
# end

# task :compile_assets, roles: :rails do
#   run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
#   # run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:cdn"
# end

# task :migrate_db, roles: :rails do
#   run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:migrate"
# end
# after 'deploy:finalize_update', 'deploy:symlink', :link_shared, :migrate_db, :compile_assets

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

#部署时输出的日志等级为debug
# set :log_level, :info

set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn", "#{fetch(:rails_env)}.rb") }
set :unicorn_roles, -> { :app }
set :unicorn_options, -> { "" }
set :unicorn_rack_env, -> { fetch(:rails_env) == "development" ? "development" : "deployment" }
set :unicorn_restart_sleep_time, 3
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  task :restart do
    invoke 'unicorn:restart'
  end

end
