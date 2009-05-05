namespace :flex do
  require 'rbconfig'
  win = Config::CONFIG['host_os'] =~ /mswin|mingw/
  suffix = win ? '.bat' : ''
  build = win ? 'build.bat' : './build.sh'
  set_path='export PATH="/Applications/Adobe Flex Builder 3/sdks/3.0.0/bin":$PATH'
  run = "#{set_path};adl applicationdescriptor.xml"
  
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

  desc 'Run air app'
  task :run_air_app do
    Dir.chdir('website/demo-app') do
      sh run
    end
  end

end