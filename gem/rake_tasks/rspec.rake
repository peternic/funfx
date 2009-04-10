require 'rubygems'
require 'spec/rake/spectask'

namespace :spec do
  desc "Run the API specs"
  Spec::Rake::SpecTask.new(:api) do |t|
    t.rcov = true
    t.rcov_opts = ["--exclude gems,spec"]
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/funfx/flex/**/*_spec.rb']
  end
  
  desc "Run the script specs"
  Spec::Rake::SpecTask.new(:script) do |t|
    t.rcov = true
    t.rcov_opts = ["--exclude gems,spec"]
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/funfx/script/**/*_spec.rb']
  end

  desc "Run the meta specs (code generation)"
  Spec::Rake::SpecTask.new(:meta) do |t|
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/funfx/meta/**/*_spec.rb']
  end

  desc "Run the Demo App specs"
  Spec::Rake::SpecTask.new(:demo_app) do |t|
    t.rcov = true
    t.rcov_opts = ["--exclude gems,spec"]
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/funfx/demo_app/**/*_spec.rb']
  end
end

task :spec => ['spec:api', 'spec:script', 'spec:meta', 'spec:demo_app']