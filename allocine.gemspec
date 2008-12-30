Gem::Specification.new do |s|
  s.name     = "allocine"
  s.version  = "0.2.1"
  s.date     = "2008-12-30"
  s.summary  = "Allocine.fr parser"
  s.email    = "jordan@lifeisdead.net"
  s.homepage = "http://github.com/webs/allocine"
  s.description = "Allocine.fr parser"
  s.has_rdoc = false
  s.authors  = ["Jordan Bracco", "Sunny Ripert"]
  s.files    = ["README.textile", 
    "allocine.gemspec", 
    "lib/allocine.rb",
    "lib/allocine/allocine.rb",
    "lib/allocine/movie.rb", 
    "lib/allocine/show.rb"
  ]
  s.test_files = ["spec/allocine.rb", 
    "spec/helper.rb",
    "spec/movie.rb",
    "spec/show.rb"
  ]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  #s.add_dependency("diff-lcs", ["> 0.0.0"])
  #s.add_dependency("mime-types", ["> 0.0.0"])
  #s.add_dependency("open4", ["> 0.0.0"])
end