require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "site_meta"
    gem.summary = %Q{helpers for easy adding of html meta information in web applications}
    gem.description = %Q{Provides helpers for easy adding of html meta information to Rails applications.
 * Easily add default description and keywords meta tags.
 * Customize meta tags on per-view basis
 * Add head title tag with breadcrubms
 * Add page title}
    gem.email = "bragi@ragnarson.com"
    gem.homepage = "http://github.com/bragi/site_meta"
    gem.authors = ["Łukasz Piestrzeniewicz"]
    gem.add_dependency("rails", ">=2.3.5")
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "site_meta #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
