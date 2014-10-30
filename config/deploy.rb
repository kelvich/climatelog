# config valid only for Capistrano 3.1
module GitStrategy
  require 'capistrano/git'
  include Capistrano::Git::DefaultStrategy
  def release
    git :archive, fetch(:branch), '| tar -x -f - -C', release_path
  end
end

set :git_strategy, GitStrategy

lock '3.2.1'

set :application, 'climatelog'
set :repo_url, 'https://github.com/kelvich/climatelog.git'

set :deploy_to, '/usr/local/www/climatelog/'
