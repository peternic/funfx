require 'erb'
require 'active_support'
require File.dirname(__FILE__) + '/config'

namespace :test do
  namespace :build do
    desc "Rebuilds the test suite file"
    task :suite do
      project = Project.new(test_config.test_dir)

      @test_suite_name = test_config.test_suite_name
      @packages = project.packages
      @package_test_sets = project.package_test_sets

      @task_name = 'test:build:suite'

      @test_suite_name = test_config.test_suite_name
      @test_initializer = test_config.test_initializer
      ErbHelper.write('TestSuite.as.erb', test_config.test_suite_file, binding)
    end

    task :runner do
      @test_suite_name = test_config.test_suite_name
      ErbHelper.write('TestRunner.mxml.erb', test_config.test_runner_file, binding)
    end
  end
end

class ErbHelper
  def self.write(template_name, target, binding)
    puts "Writing #{template_name} to #{target}"
    File.open(target, 'w') do |file|
      template = File.join(File.dirname(__FILE__), 'test', template_name)

      test_suite = ERB.new(File.read(template), nil, "%>").result(binding)

      file.puts(test_suite)
    end
  end
end

class Project
  def initialize(test_directory)#, file_filter)
    @test_directory = test_directory
  end

  def package_test_sets
    test_files_by_directory.inject({}) do |sets, (directory, files)|
      test_names = files.map { |file| test_name_for(file) }
      
      sets.merge!(package_name_for(directory) => test_names.sort!)
    end.to_hash
  end

  def packages
    package_test_sets.keys
  end

  private
  def test_file_directories
    test_files_by_directory.keys
  end

  def test_files_by_directory
    test_files.group_by { |file| File.dirname(file) }
  end

  def test_name_for(file)
    File.basename(file).gsub(/\.as$/, '')
  end

  def package_name_for(directory)
    directory.gsub(@test_directory + File::SEPARATOR, '').gsub(File::SEPARATOR, '.')
  end

  def test_files
    Dir[File.join(@test_directory, '**', '*Test.as')].select { |file| File.file?(file) }
  end
end

class TestConfig < Rake::Config
  def test_suite_name
    "#{app_name}TestSuite"
  end

  def test_runner_name
    "#{app_name}TestRunner"
  end

  def test_runner_file
    File.join(test_suite_dir, "#{test_runner_name}.mxml")
  end

  def test_suite_file
    File.join(test_suite_dir, "#{test_suite_name}.as")
  end
end

TestConfig.configure do |config|
  config.add(:test_initializer, :required => false)
  config.add(:app_name, :default => 'App')
  config.add(:test_dir, :default => File.join('test', 'unit'))
  config.add(:test_suite_dir, :default => Proc.new { |config| config.test_dir })
end

def test_config
  TestConfig.instance
end