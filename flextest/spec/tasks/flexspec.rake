require 'fileutils'
require File.dirname(__FILE__) + '/config'

namespace :flexspec do
  task :update => [:update_cache] do
    # rm_rf(flexspec_config.install_location)
    flexspec_config.files_of_interest.each do |file|
      cp_r(File.join(flexspec_config.local_cache, file), flexspec_config.install_location)
    end
  end

  task :update_cache do
    if File.exists?(flexspec_config.local_cache) && (current_cache_repo_location == flexspec_config.repo_location)
      puts "Updating flexspec cache at #{flexspec_config.local_cache}"
      Dir.chdir(flexspec_config.local_cache) do
        system("git pull")
      end
    elsif File.exists?(flexspec_config.local_cache)
      puts "Removing old flexspec cache (#{current_cache_repo_location}) and replacing it with #{flexspec_config.repo_location}"
      rm_rf(flexspec_config.local_cache)
      system("git clone #{flexspec_config.repo_location} #{flexspec_config.local_cache}")
    else
      puts "Doing initial clone of #{flexspec_config.repo_location} to #{flexspec_config.local_cache}"
      system("git clone #{flexspec_config.repo_location} #{flexspec_config.local_cache}")
    end
  end

  def current_cache_repo_location
    Dir.chdir(flexspec_config.local_cache) do
      show_info = %x[git remote show origin -n]
      show_info.match(/^.*URL: (.*)/)[1].chomp
    end
  end
end

class FlexspecConfig
  include Singleton

  {:install_location => 'spec',
   :repo_location => 'git://github.com/moneypools/flexspec.git',
   :local_cache => File.join('tmp', 'flexspec'),
   :files_of_interest => [File.join('flexspec', 'tasks')]}.each_pair do |setting, default|

    attr_writer setting
    define_method(setting) do
      instance_variable_get("@#{setting}") || default
    end
  end
end

def flexspec_config
  FlexspecConfig.instance
end