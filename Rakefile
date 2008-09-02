require 'rbconfig'
win = Config::CONFIG['host_os'] =~ /mswin|mingw/
suffix = win ? '.bat' : ''

desc 'Compile everything and run specs'
task :everything => [:demo_app, :codegen, :spec]

desc 'Compile FunFX Flex code'
task :flex do
  Dir.chdir('flex') do
    sh "build#{suffix}"
  end
end

desc 'Compile the Demo app'
task :demo_app => :flex do
  Dir.chdir('demo-app') do
    sh "build#{suffix}"
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

task :default => :everything