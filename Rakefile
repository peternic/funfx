require 'rbconfig'
win = Config::CONFIG['host_os'] =~ /mswin|mingw/
suffix = win ? '.bat' : ''
build = win ? 'build.bat' : './build.sh'

desc 'Compile the Demo app'
task :demo_app do
  Dir.chdir('gem') do
    sh "rake flex:compile_demo_app"
  end
end

desc 'Generate Ruby code'
task :generate do
  Dir.chdir('gem') do
    sh "rake generate:code"
  end
end

desc 'Run specs'
task :spec => [:demo_app] do
  Dir.chdir('gem') do
    sh "rake spec"
  end
end

desc 'Compile Rubygem'
task :gem => [:flex, :generate] do
  Dir.chdir('gem') do
    sh "rake gem"
  end
end

desc 'Compile FunFX Flex code'
task :flex do
  Dir.chdir('gem') do
    sh "rake flex:compile"
  end
end

desc 'Run httpd'
task :httpd do
  Dir.chdir('gem') do
    sh "rake start_local_httpd"
  end
end

desc 'Start air application'
task :air do
  Dir.chdir('gem') do
    sh "rake flex:run_air_app"
  end
end

namespace :components do
  desc 'Create xml for custom components'
  task :generate_xml_for_custom_components, :directory do |t, args|
    Dir.chdir('gem') do
      sh "rake components:generate_xml[args.directory]"
    end
  end

  desc 'Add custom components to the xml'
  task :add_custom_components_to_xml do
    Dir.chdir('gem') do
      sh "rake components:concat"
    end
  end
end


task :default => :gem

