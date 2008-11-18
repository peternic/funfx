Gem::Specification.new do |s|
  s.name = %q{funfx}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Nicolai Motzfeldt", "Aslak Helles\303\270y"]
  s.date = %q{2008-11-18}
  s.description = %q{description of gem}
  s.email = ["motzfeldt@gmail.com", "aslak.hellesoy@gmail.com"]
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
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
