# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{site_meta}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lukasz Piestrzeniewicz"]
  s.date = %q{2009-01-08}
  s.description = %q{Provides helpers for easy adding of html meta information to Rails applications.}
  s.email = ["bragi@ragnarson.com"]
  s.extra_rdoc_files = ["History.txt", "README.rdoc"]
  s.files = ["History.txt", "init.rb", "lib/site_meta.rb", "rails/init.rb", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bragi/site_meta}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{site_meta}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Provides helpers for easy adding of html meta information to Rails applications.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 1.0.0"])
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<actionpack>, [">= 1.0.0"])
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 1.0.0"])
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
