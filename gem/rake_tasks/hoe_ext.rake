task :release do

  puts "Uploading FunFX.swc....."
  rf = RubyForge.new.configure
  rf.login
  rf.add_file("funfx", "funfx", FunFX::VERSION::STRING, File.dirname(__FILE__) + '/../../flex/FunFX.swc')

  puts %{
****************************************
Now it's time to make a tag in Git:

git tag -a "v#{FunFX::VERSION::STRING}" -m "Release #{FunFX::VERSION::STRING}"
git push --tags
****************************************
  }
end