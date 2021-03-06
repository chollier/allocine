require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "allocine"
    gem.summary = %Q{Parser for Allocine.fr}
    gem.description = %Q{Get data about movies and shows on allocine.fr}
    gem.email = "jordan@bracco.name"
    gem.homepage = "http://code.webs.ly/allocine"
    gem.authors = ["Jordan Bracco", "Florian Lamache", "Sunny Ripert"]
    gem.rubyforge_project = "allocine"
    gem.add_development_dependency "rspec", ">= 0"
    gem.add_dependency("activesupport", ["> 0.0.0"])
    gem.add_dependency("vegas", ["> 0.0.0"])
    gem.add_dependency("sinatra", ["> 0.0.0"])
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_opts = ['--color', '--format nested']
  spec.ruby_opts = ['-rrubygems']
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.ruby_opts = ['-rrubygems']
  spec.rcov = true
end

task :spec => :check_dependencies
  
task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "allocine #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
  end
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run YARD, you must: sudo gem install yard (or use rdoc: `rake rdoc`)"
  end
end
