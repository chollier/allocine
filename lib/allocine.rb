$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'open-uri'
require 'iconv'
require 'allocine/allocine'
require 'allocine/movie'
require 'allocine/show'
MOVIE_SEARCH_URL = "http://www.allocine.fr/recherche/1/?q=%s"
MOVIE_DETAIL_URL = "http://www.allocine.fr/film/fichefilm_gen_cfilm=%s.html"
SHOW_SEARCH_URL = "http://www.allocine.fr/recherche/6/?q=%s"
SHOW_DETAIL_URL = "http://www.allocine.fr/series/ficheserie_gen_cserie=%s.html"
