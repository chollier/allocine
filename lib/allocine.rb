$:.unshift File.dirname(__FILE__)

require 'activesupport'

%w{allocine/web allocine/allocine allocine/movie allocine/show}.each do |lib|
  require lib
end

begin
  require 'curb'
  require 'zlib'
  require 'allocine/web/curb'
  Allocine::Web.send(:include, Allocine::WebCurb)
rescue LoadError
  require 'open-uri'
  require 'allocine/web/open_uri'
  Allocine::Web.send(:include, Allocine::WebOpenUri)
end

MOVIE_SEARCH_URL = "http://www.allocine.fr/recherche/1/?q=%s"
MOVIE_DETAIL_URL = "http://www.allocine.fr/film/fichefilm_gen_cfilm=%s.html"
SHOW_SEARCH_URL = "http://www.allocine.fr/recherche/6/?q=%s"
SHOW_DETAIL_URL = "http://www.allocine.fr/series/ficheserie_gen_cserie=%s.html"
