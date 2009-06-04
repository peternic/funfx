namespace :flex do
  require 'rbconfig'
  win = Config::CONFIG['host_os'] =~ /mswin|mingw/
  suffix = win ? '.bat' : ''
  build = win ? 'build.bat' : './build.sh'

  desc 'Compile FunFX Flex code'
  task :compile do
    Dir.chdir('flex/src/main/flex') do
      #sh "#{compiler("compc")} -load-config+=build_funfx_swc.xml -o bin/funfx-#{VERS}.swc"
      sh build
    end
  end

  desc 'Compile FunFX demo app code'
  task :compile_demo_app => :compile do
    Dir.chdir('demo-app') do
      #sh "#{compiler("mxmlc")} -include-libraries ../flex/src/main/flex/bin/funfx-#{VERS}.swc -load-config+=build_demo_app_swc.xml"
      sh build
    end
  end

  desc 'Run air app'
  task :run_air_app do
    Dir.chdir('website/demo-app') do
      sh run
    end
  end

  def compiler(binary)
    flex_home = (ENV['FLEX_HOME'] || ENV['FLEX_SDK_HOME']).to_s

    if flex_home != "" && File.directory?(flex_home)
      File.expand_path(File.join(flex_home, 'bin', binary))      
    elsif system("which #{binary}")
      "#{binary}"
    else
      raise "Unable to find #{binary}. Please ensure that $FLEX_HOME or $FLEX_SDK_HOME are pointing to the Flex base dir."
    end
  end
end
