module Allocine
class Movie
  attr_accessor :title, :directors, :nat, :genres, :out_date, :duree, :production_date, :original_title, :actors, :synopsis, :image, :interdit
  
  def self.find(search)
    search.gsub!(' ', '+')
    str = open(MOVIE_SEARCH_URL % search).read.to_s
    movies = {}
    while str =~ /<a href='\/film\/fichefilm_gen_cfilm=(\d+).html'>(.*?)<\/a>/mi
      id, name = $1, $2
      unless name =~ /<img(.*?)/
        str.gsub!("<a href=\'/film/fichefilm_gen_cfilm=#{id}.html\'>#{name}</a>", "")
        name.gsub!(/<(.+?)>/,'')
        name.strip!
        movies[id] = name
      else
        str.gsub!("<a href=\'/film/fichefilm_gen_cfilm=#{id}.html\'>#{name}</a>", "")
      end
    end
    movies
  end
  
  def self.lucky_find(search)
    results = find(search)
    new(results.keys.first)
  end
  
  def initialize(id, debug=false)
    regexps = {
      :title => '<div class="titlebar">.*<h1>(.*?)<\/h1>.*</div>',
      :directors => 'Réalisé par <span class="bold"><a .*?>(.*?)<\/a>',
      :nat => 'Long-métrage (.*?)\.',
      :genres => 'Genre :.*?(.*?)<br/>',
      :out_date => 'Date de sortie cinéma :.*?<span class="bold">(.*?)</span>',
      :duree => 'Durée :.*?(.*?)\.',
      :production_date => 'Année de production :.*?(.*?)<br/><br />',
      :original_title => 'Titre original : <span class="purehtml"><em>(.*?)</em></span>',
      :actors => 'Avec (.*?)&nbsp;&nbsp;',
      :synopsis => '<p class="">.*?<span class="bold">Synopsis :</span>(.*?)</p>',
      :image => '<a href="/film/.*?/affiches/">.*?<img src=\'(.*?)\'.*?alt=".*?".*?title=".*?".*?/>',
      :interdit => '<h4 style="color: #D20000;">Interdit(.*?)</h4>'
    }
    data = open(MOVIE_DETAIL_URL % id).read.to_s
    regexps.each do |reg|
      print "#{reg[0]}: " if debug
      r = data.scan Regexp.new(reg[1], Regexp::MULTILINE)
      r = r.first.to_s.strip
      r.gsub!(/<.*?>/, '')
      r.strip!
      self.instance_variable_set("@#{reg[0]}", r)
      print "#{r}\n" if debug
    end
  end
end
end