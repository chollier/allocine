$:.unshift File.dirname(__FILE__)

require 'activesupport'

%w{allocine/web allocine/movie allocine/show}.each do |lib|
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

module Allocine
  MOVIE_SEARCH_URL = "http://www.allocine.fr/recherche/1/?q=%s"
  MOVIE_DETAIL_URL = "http://www.allocine.fr/film/fichefilm_gen_cfilm=%s.html"
  SHOW_SEARCH_URL = "http://www.allocine.fr/recherche/6/?q=%s"
  SHOW_DETAIL_URL = "http://www.allocine.fr/series/ficheserie_gen_cserie=%s.html"
  
  # Make a search on movies
  def self.find_movie(search)
    Allocine::Movie.find(search)
  end
  
  # Make a search on shows
  def self.find_show(search)
    Allocine::Show.find(search)
  end
  
  # Returns the first result
  def self.lucky_movie(search)
    Allocine::Movie.lucky_find(search)
  end
  
  def self.lucky_show(search)
    Allocine::Show.lucky_find(search)
  end
end