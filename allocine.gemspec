Gem::Specification.new do |s|
  s.name     = "allocine"
  s.version  = "0.4.0"
  s.date     = "2009-11-18"
  s.summary  = "Allocine.fr parser"
  s.email    = "florian@e-lam.net"
  s.homepage = "http://github.com/Florian95/allocine"
  s.description = "Allocine.fr Ruby Wrapper"
  s.has_rdoc = false
  s.authors  = ["Jordan Bracco", "Sunny Ripert", "Florian LAMACHE"]
  s.files    = ["README.textile", 
    "allocine.gemspec", 
    "lib/allocine.rb",
    "lib/allocine/tools.rb",
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