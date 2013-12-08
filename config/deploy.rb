set :application, 'freedom-shop'
set :scm, "git"
set :repo_url, "https://github.com/red-crown/freedom-shop.git"
set :copy_cach, true
set :copy_via, :scp
set :branch, "master"
set :deploy_via, :copy

role :web, "192.227.160.74"
role :app, "192.227.160.74"
role :db, "192.227.160.74", :primary => true
role :db, "192.227.160.74"

set :user, 'frosty'
server '192.227.160.74', user: 'frosty', roles: %w{web app db} 
set :deploy_to, "/home/#{fetch(:user)}/Applications/#{fetch(:application)}"

set :ssh_options, {
  user: %w(user),
  keys: %w(/home/matthew/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
set :use_sudo, false

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Restart Passenger app"
  task :restart do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

