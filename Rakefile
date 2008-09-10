require 'rbconfig'
win = Config::CONFIG['host_os'] =~ /mswin|mingw/
suffix = win ? '.bat' : ''
build = win ? 'build.bat' : './build.sh'

desc 'Compile everything and run specs'
task :everything => [:demo_app, :codegen, :spec]

desc 'Compile FunFX Flex code'
task :flex do
  Dir.chdir('flex') do
    sh build
  end
end

desc 'Compile the Demo app'
task :demo_app => :flex do
  cp 'flex/src/AutoQuickEnv.xml', 'demo-app/lib/AutoQuickEnv.xml'
  Dir.chdir('demo-app') do
    sh build
  end
end

desc 'Generate Ruby code'
task :codegen do
  Dir.chdir('gem') do
    ruby "lib/funfx/codegen/code_generator.rb"
  end
end

desc 'Run specs'
task :spec do
  Dir.chdir('gem') do
    sh "rake#{suffix} spec"
  end
end

desc 'Run httpd'
task :httpd do
  ruby "demo-app/lib/httpd.rb"
end

task :default => :everything