namespace :gemspec do
  desc 'Refresh funfx.gemspec to include ALL files'
  task :refresh => 'manifest:refresh' do
    File.open('funfx.gemspec', 'w') {|io| io.write($hoe.spec.to_ruby)}
  end
end