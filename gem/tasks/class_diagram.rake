desc "Generate class diagram"
task :class_diagram do
  require 'funfx/meta/dot_generator'
  parser = FunFX::Meta::Parser.new
  dot_generator = FunFX::Meta::DotGenerator.new(parser)
  dot = dot_generator.generate
  File.open('website/funfx.dot', 'wb') {|io| io.write dot}
  sh "dot -T png -o website/funfx.png website/funfx.dot"
  sh "dot -T svg -o website/funfx.svg website/funfx.dot"
end