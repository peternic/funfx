require 'rbconfig'
win = Config::CONFIG['host_os'] =~ /mswin|mingw/
suffix = win ? '.bat' : ''
build = win ? 'build.bat' : './build.sh'

cp 'flex/src/AutoQuickEnv.xml', 'gem/ext/AutoQuickEnv.xml'

desc 'Compile the Demo app'
task :demo_app => :flex do
  Dir.chdir('demo-app') do
    sh build
  end
end

desc 'Generate Ruby code'
task :generate do
  Dir.chdir('gem') do
    sh "rake#{suffix} generate:code"
  end
end

desc 'Run specs'
task :spec => [:demo_app] do
  Dir.chdir('gem') do
    sh "rake#{suffix} spec"
  end
end

desc 'Compile Rubygem'
task :gem => [:flex, :generate] do
  Dir.chdir('gem') do
    sh "rake#{suffix} gem"
  end
end

desc 'Compile FunFX Flex code'
task :flex do
  Dir.chdir('flex') do
    sh build
  end
end

desc 'Run httpd'
task :httpd do
  ruby "gem/website/demo-app/httpd.rb"
end

task :default => :gem
