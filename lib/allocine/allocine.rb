module Allocine
  
  # Make a search on movies
  def self.find_movie(search)
    search = search.gsub(' ', '+')
    str = open(MOVIE_SEARCH_URL % search).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    films = {}
    while data =~ /<a href="\/film\/fichefilm_gen_cfilm=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      data.gsub!("<a href=\"/film/fichefilm_gen_cfilm=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      films[id] = name
    end
    films
  end
  
  # Make a search on shows
  def self.find_show(search)
    search = search.gsub(' ', '+')
    str = open(SHOW_SEARCH_URL % search).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    shows = {}
    while data =~ /<a href="\/series\/ficheserie_gen_cserie=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      data.gsub!("<a href=\"/series/ficheserie_gen_cserie=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      shows[id] = name
    end
    shows
  end
  
  # Returns the first result
  def self.lucky_movie(search)
    results = self.find_movie(search)
    Allocine::Movie.new(results.keys.first)
  end
  
  def self.lucky_show(search)
    results = self.find_show(search)
    Allocine::Show.new(results.keys.first)
  end
end