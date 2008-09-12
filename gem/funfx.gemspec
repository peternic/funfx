Gem::Specification.new do |s|
  s.name = %q{funfx}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Nicolai Motzfeldt", "Aslak Helles\303\270y"]
  s.date = %q{2008-09-12}
  s.description = %q{description of gem}
  s.email = ["motzfeldt@gmail.com", "aslak.hellesoy@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "ext/FunFX.swc", "lib/funfx.rb", "lib/funfx/codegen/code_generator.rb", "lib/funfx/firewatir.rb", "lib/funfx/flex/element.rb", "lib/funfx/flex/generated_elements.rb", "lib/funfx/flex/tabular_data.rb", "lib/funfx/safari.rb", "lib/funfx/version.rb", "lib/funfx/watir.rb", "script/console", "script/console.cmd", "script/destroy", "script/destroy.cmd", "script/generate", "script/generate.cmd", "script/txt2html", "script/txt2html.cmd", "setup.rb", "spec/funfx/demo_app/alert_spec.rb", "spec/funfx/demo_app/button_bar_spec.rb", "spec/funfx/demo_app/button_spec.rb", "spec/funfx/demo_app/data_grid_spec.rb", "spec/funfx/demo_app/repeater_control_spec.rb", "spec/funfx/flex/element_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/gemspec.rake", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://funfx.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = %q{funfx}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{description of gem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
