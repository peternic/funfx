Gem::Specification.new do |s|
  s.name = %q{funfx}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Nicolai Motzfeldt", "Aslak Helles\303\270y"]
  s.date = %q{2008-11-21}
  s.description = %q{description of gem}
  s.email = ["motzfeldt@gmail.com", "aslak.hellesoy@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "ext/FunFX.swc", "lib/funfx.rb", "lib/funfx/browser/firewatir.rb", "lib/funfx/browser/flex_app_lookup.rb", "lib/funfx/browser/safariwatir.rb", "lib/funfx/browser/watir.rb", "lib/funfx/decoder.rb", "lib/funfx/flex/element.rb", "lib/funfx/flex/elements.rb", "lib/funfx/flex/flex_app_id.rb", "lib/funfx/flex/tabular_data.rb", "lib/funfx/meta/class_dot.erb", "lib/funfx/meta/code.erb", "lib/funfx/meta/generator.rb", "lib/funfx/meta/parser.rb", "lib/funfx/version.rb", "rake_tasks/deployment.rake", "rake_tasks/environment.rake", "rake_tasks/gemspec.rake", "rake_tasks/generation.rake", "rake_tasks/rspec.rake", "script/console", "script/console.cmd", "script/destroy", "script/destroy.cmd", "script/generate", "script/generate.cmd", "script/txt2html", "script/txt2html.cmd", "setup.rb", "spec/funfx/demo_app/accordion_spec.rb", "spec/funfx/demo_app/advanced_data_grid_spec.rb", "spec/funfx/demo_app/alert_spec.rb", "spec/funfx/demo_app/button_bar_spec.rb", "spec/funfx/demo_app/button_spec.rb", "spec/funfx/demo_app/check_box_spec.rb", "spec/funfx/demo_app/controls_with_same_id_spec.rb", "spec/funfx/demo_app/data_grid_spec.rb", "spec/funfx/demo_app/date_chooser_spec.rb", "spec/funfx/demo_app/date_field_spec.rb", "spec/funfx/demo_app/form_spec.rb", "spec/funfx/demo_app/grid_layout_spec.rb", "spec/funfx/demo_app/h_scrollbar_spec.rb", "spec/funfx/demo_app/h_slider_spec.rb", "spec/funfx/demo_app/horizontal_list_spec.rb", "spec/funfx/demo_app/label_spec.rb", "spec/funfx/demo_app/link_bar_spec.rb", "spec/funfx/demo_app/link_button_spec.rb", "spec/funfx/demo_app/list_spec.rb", "spec/funfx/demo_app/menu_bar_spec.rb", "spec/funfx/demo_app/menu_spec.rb", "spec/funfx/demo_app/numeric_stepper_spec.rb", "spec/funfx/demo_app/popup_button_spec.rb", "spec/funfx/demo_app/popup_menu_bar_spec.rb", "spec/funfx/demo_app/progress_bar_spec.rb", "spec/funfx/demo_app/radio_button_group_spec.rb", "spec/funfx/demo_app/radio_button_spec.rb", "spec/funfx/demo_app/record_test_spec.rb", "spec/funfx/demo_app/repeater_control_spec.rb", "spec/funfx/demo_app/tab_bar_spec.rb", "spec/funfx/demo_app/tab_navigator_spec.rb", "spec/funfx/demo_app/text_area_spec.rb", "spec/funfx/demo_app/text_input_spec.rb", "spec/funfx/demo_app/text_spec.rb", "spec/funfx/demo_app/tile_button_spec.rb", "spec/funfx/demo_app/tile_list_spec.rb", "spec/funfx/demo_app/title_window_spec.rb", "spec/funfx/demo_app/toggle_button_spec.rb", "spec/funfx/demo_app/tree_drag_and_drop_spec.rb", "spec/funfx/demo_app/tree_spec.rb", "spec/funfx/demo_app/view_stack_spec.rb", "spec/funfx/flex/element_spec.rb", "spec/funfx/flex/flex_app_id_spec.rb", "spec/funfx/meta/generator_spec.rb", "spec/funfx/meta/parser_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
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
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
