set :application, "icreatedsomethingcool"

default_run_options[:pty] = true

ssh_options[:forward_agent] = true

set :repository,  "git@gitbase.com:dancingorange/i-created-something-cool/main.git"
set :scm, "git"
#set :scm_passphrase, "p@ssw0rd" #This is your custom users password
set :user, "root"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/usr/local/www/#{application}"

role :app, "67.207.149.24"
role :web, "67.207.149.24"
role :db,  "67.207.149.24", :primary => true

#required for OS X!!!
on :start do
  `ssh-add`
end

namespace :deploy do
  task :start do
    before_deploy
    sleep(3)
    run "cd #{current_path}; rm log -r && mkdir log"
    run "cd #{current_path}; merb -p 6000 -e production -a thin -d"
  end
  
  task :stop do
    before_deploy
  end
  
  task :restart do
    start
  end
    
  task :before_deploy do
    run "merb -m #{current_path} -K all"
  end
end