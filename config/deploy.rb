set :application, 'freedom-shop'
set :scm, "git"
set :repo_url, "https://github.com/red-crown/freedom-shop.git"
set :copy_cach, true
set :copy_via, :scp
set :branch, "master"
set :deploy_via, :copy

set :user, 'frosty'
set :deploy_to, "/home/#{fetch(:user)}/Applications/#{fetch(:application)}"

role :web, "192.227.160.74"
role :app, "192.227.160.74"
role :db,  "192.227.160.74", :primary => true

server '192.227.160.74', user: 'frosty', roles: %w{web app db} 

set :ssh_options, {
  user: %w(user),
  keys: %w(/home/matthew/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
set :use_sudo, false

set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p195'
set :rvm_custom_path, '~/.rvm'


set :log_level, :info

set :format, :pretty
set :pty, true

set :default_env, { rvm_bin_path: "~/.rvm/bin" }
set :bundle_gemfile, -> { relase_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, ''
set :bundle_without, %w{test development}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
set :bundle_bins, %w(gem rake rails)

#set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system public/uploads}

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("/tmp/restart.txt")
    end
  end

  after :finishing, "deploy:cleanup"

end

