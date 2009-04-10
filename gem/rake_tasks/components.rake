namespace :components do
  desc "Generate xml for custom components"
  task :generate_xml, :directory do |t, args|
    require 'funfx/script/custom_component_parser'

    parser = FunFX::Script::CustomComponentParser.new(File.join("flex", "src", "main", "flex", "src"), "AutoQuickEnvTemp.xml")
    parser.create_xml_for_custom_components(args.directory)
  end
  
  desc "Clears the generated xml file"
  task :clear do
    begin
      File.delete(File.join("flex", "src", "main", "flex", "src", "AutoQuickEnvTemp.xml"))
    rescue
    
    end
  end
  
  desc "Concats the generated xml file with the FunFX base file"
  task :concat do
    require 'funfx/script/parent_locator'
    require 'funfx/script/file_helper'
    
    parent_locator = FunFX::Script::ParentLocator.new
    parent_locator = FunFX::Script::ParentLocator.new
    
    new_xml_file = File.join("flex", "src", "main", "flex", "src","AutoQuickEnv.xml")
    xml_base_file = File.join("flex", "src", "main", "flex", "src","AutoQuickEnvBase.xml")
    components_xml_file = File.join("flex", "src", "main", "flex", "src","AutoQuickEnvTemp.xml")
    
    new_xml = File.new(new_xml_file, "w")
    xml_base = File.new(xml_base_file, "r")
    components_xml = File.new(components_xml_file, "r") unless !File.exist?(components_xml_file)
    
    parent_locator.build_object_list(xml_base_file)
    parent_locator.build_object_list(components_xml_file) unless !File.exist?(components_xml_file)
    
    while(xml_base_line = xml_base.gets)
      next if(File.exist?(components_xml_file) && xml_base_line.strip.eql?("</TypeInformation>"))
      new_xml << xml_base_line
    end
    
    if(File.exist?(components_xml_file))
      while(components_xml_line = components_xml.gets)
        
        if(parent_locator.is_start_of_class(components_xml_line))
          parent_locator.class_def_exists_from_line?(components_xml_line)
        end
        if(!parent_locator.should_skip?)
          new_xml << "\t#{components_xml_line}"
        end
      end
      components_xml.close
      new_xml << "</TypeInformation>"
    end
  
    xml_base.close
    new_xml.close
  end
end