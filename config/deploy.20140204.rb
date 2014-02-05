set :application, "the_marketing_calendar"
set :repository,  "https://github.com/prohner/themarketingcalendar.git"

set :deploy_to, "/home/preston/Sites/the_marketing_calendar"
set :scm, :git
set :branch, "master"
set :user, "preston"
set :password, nil
set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true }
set :keep_releases, 5
default_run_options[:pty] = true
server "216.133.6.38", :app, :web, :db, :primary => true



# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
   # run "#{ sudo } ln -s #{ deploy_to }/shared/config/environment.rb #{ current_path }/config/environment.rb"
   # run "#{ sudo } ln -s #{ deploy_to }/shared/config/initializers/devise.rb #{ current_path }/config/initializers/devise.rb"
    # run "#{ sudo } ln -s #{ deploy_to }/shared/config/initializers/secret_token.rb #{ current_path }/config/initializers/secret_token.rb"
    #run "#{ sudo } ln -s #{ deploy_to }/shared/app/mailers/user_mailer.rb #{ current_path }/app/mailers/user_mailer.rb"
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/initializers/setup_mail.rb #{ current_path }/config/initializers/setup_mail.rb"
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/initializers/private_constants.rb #{ current_path }/config/initializers/private_constants.rb"
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/initializers/devise.rb #{ current_path }/config/initializers/devise.rb"
  end

  #Assets
  desc "Precompile assets after deploy"
  task :precompile_assets do
    run <<-CMD
      cd #{ current_path } &&
      #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
    CMD
  end

  desc "Restart applicaiton"
  task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end
