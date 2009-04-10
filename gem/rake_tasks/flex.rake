namespace :flex do
  require 'rbconfig'
  win = Config::CONFIG['host_os'] =~ /mswin|mingw/
  suffix = win ? '.bat' : ''
  build = win ? 'build.bat' : './build.sh'
  
  desc 'Compile FunFX Flex code'
  task :compile do
    Dir.chdir('flex/src/main/flex') do
      sh build
    end
  end
  
  desc 'Compile FunFX demo app code'
  task :compile_demo_app => :compile do
    Dir.chdir('demo-app') do
      sh build
    end
  end
end