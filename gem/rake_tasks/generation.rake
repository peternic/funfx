namespace :generate do
  desc "Generate class diagrams"
  task :diagrams do
    require 'funfx/meta/generator'
    
    diagrams = {
      :all    => nil,
      :first  => %w{FlexMenuBar FlexLabel FlexObject},
      :second => %w{FlexButton FlexRadioButton FlexPopUpButton FlexCheckBox FlexDateChooser FlexSlider},
      :third  => %w{FlexLabel FlexProgressBar FlexNumericStepper FlexLoader FlexRule FlexVideoDisplay},
    }
    
    lib = FunFX::Meta::ClassLib.new
    diagrams.each do |file, names|
      classes = lib.classes(names)
      generator = FunFX::Meta::Generator.new(classes, :class_dot)
      dot = "website/diagrams/#{file}.dot"
      pdf = "website/diagrams/#{file}.pdf"
      File.open(dot, 'wb') {|io| io.write generator.generate}
      sh "dot -T pdf -o #{pdf} #{dot}"
    end
  end

  desc "Generate code"
  task :code do
    require 'funfx/meta/generator'
    
    lib = FunFX::Meta::ClassLib.new
    classes = lib.classes
    generator = FunFX::Meta::Generator.new(classes, :code)
    code = 'lib/funfx/flex/elements.rb'
    File.open(code, 'wb') {|io| io.write generator.generate}
  end
end