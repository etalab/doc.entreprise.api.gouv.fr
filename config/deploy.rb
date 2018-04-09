require 'mina/rails'
require 'mina/bundler'
require 'mina/git'
require 'mina/rbenv'
require 'colorize'

ENV['to'] = "production"
print "Deploy to #{ENV['to']} environment\n".green

ENV['domain'] || raise('no domain provided'.red)

set :user, 'deploy'
set :application_name, 'doc.entreprise.api.gouv.fr'
set :domain, ENV['domain']

set :deploy_to, "/var/www/doc.entreprise.api.gouv.fr"
set :repository, 'git@github.com:etalab/doc.entreprise.api.gouv.fr.git'

set :forward_agent, true
set :port, 22

set :branch, 'master'
ensure!(:branch)

task :remote_environment do
  if ENV['domain'] != 'localhost'
    # Be sure to commit your .ruby-version or .rbenv-version to your repository.
    set :rbenv_path, '/usr/local/rbenv'
    invoke :'rbenv:load'
  end
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    set :bundle_options, fetch(:bundle_options) + ' --clean'
    invoke :'bundle:install'
    command %{ bundle exec middleman build --clean }
    invoke :'deploy:cleanup'
  end

end
