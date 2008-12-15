task :release do
  puts %{
************************************
Now it's time to make a tag in Git:

tag -a "v#{FunFX::VERSION::STRING}" -m "Release #{FunFX::VERSION::STRING}"
git push --tags
************************************
  }
  
end