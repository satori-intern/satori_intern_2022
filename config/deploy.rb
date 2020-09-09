# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "intern2022"
set :repo_url, "git@github.com:satori-inc/satori_intern_2022.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/user/projects/intern2022"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files,
	"config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, 
	"log",
	"tmp/pids",
	"tmp/cache",
	"tmp/sockets",
	"public/system"


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Defaults to :db role
#set :migration_role, :db

# Defaults to the primary :db server
#set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to `db:migrate`
#set :migration_command, 'db:migrate'

# Defaults to false
# Skip migration if files in db/migrate were not modified
#set :conditionally_migrate, true

# Defaults to [:web]
#set :assets_roles, [:web, :app]

# Defaults to 'assets'
# This should match config.assets.prefix in your rails config/application.rb
#set :assets_prefix, 'prepackaged-assets'

# Defaults to ["/path/to/release_path/public/#{fetch(:assets_prefix)}/.sprockets-manifest*", "/path/to/release_path/public/#{fetch(:assets_prefix)}/manifest*.*"]
# This should match config.assets.manifest in your rails config/application.rb
#set :assets_manifests, ['app/assets/config/manifest.js']

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
#set :rails_assets_groups, :assets

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
#set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
#set :keep_assets, 2

set :rbenv_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), depends on your rbenv setup
set :rbenv_ruby, '2.6.5'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

#set :bundle_roles, :all                                         # this is default
#set :bundle_config, { deployment: true }                        # this is default
#set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
#set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
#set :bundle_gemfile, -> { release_path.join('MyGemfile') }      # default: nil
#set :bundle_path, -> { shared_path.join('bundle') }             # this is default. set it to nil to use bundler's default path
#set :bundle_without, %w{development test}.join(' ')             # this is default
#set :bundle_flags, '--quiet'                                    # this is default
#set :bundle_env_variables, {}                                   # this is default
#set :bundle_clean_options, ""                                   # this is default. Use "--dry-run" if you just want to know what gems would be deleted, without actually deleting them
#set :bundle_check_before_install, true                          # default: true. Set this to false to bypass running `bundle check` before executing `bundle install`
