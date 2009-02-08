module Allocine
class Movie
  attr_accessor :title, :directors, :nat, :genres, :out_date, :duree, :production_date, :original_title, :actors, :synopsis, :image, :interdit
  
  def self.find(search)
    search.gsub!(' ', '+')
    str = open(MOVIE_SEARCH_URL % search).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    movies = {}
    while data =~ /<a href="\/film\/fichefilm_gen_cfilm=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      data.gsub!("<a href=\"/film/fichefilm_gen_cfilm=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      movies[id] = name
    end
    movies
  end
  
  def self.lucky_find(search)
    results = find(search)
    new(results.keys.first)
  end
  
  def initialize(id, debug=false)
    regexps = {
      :title => '<h1 class="TitleFilm">(.*?)<\/h1>',
      :directors => '<h3 class="SpProse">Réalisé par <a .*?>(.*?)<\/a><\/h3>',
      :nat => '<h3 class="SpProse">Film (.*?).&nbsp;</h3>',
      :genres => '<h3 class="SpProse">Genre : (.*?)</h3>',
      :out_date => '<h3 class="SpProse">Date de sortie : <b>(.*?)</b>',
      :duree => '<h3 class="SpProse">Dur\ée : (.*?).&nbsp;</h3>',
      :production_date => '<h3 class="SpProse">Année de production : (.*?)</h3>',
      :original_title => '<h3 class="SpProse">Titre original : <i>(.*?)</i></h3>',
      :actors => '<h3 class="SpProse">Avec (.*?) &nbsp;&nbsp;',
      :synopsis => '<td valign="top" style="padding:10 0 0 0"><div align="justify"><h4>(.*?)</h4>',
      :image => '<td valign="top" width="120".*?img src="(.*?)" border="0" alt=".*?" class="affichette" />',
      :interdit => '<h4 style="color: #D20000;">Interdit(.*?)</h4>'
    }
    str = open(MOVIE_DETAIL_URL % id).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    regexps.each do |reg|
      print "#{reg[0]}: " if debug
      r = data.scan Regexp.new(reg[1], Regexp::MULTILINE)
      r = r.first.to_s.strip
      r.gsub!(/<.*?>/, '')
      if r[0..0] == " "
        r = r.reverse.chop.reverse # that's a little bit ugly, but the only simple way i found to remove the first space in the out date
      end
      self.instance_variable_set("@#{reg[0]}", r)
      print "#{r}\n" if debug
    end
  end
end
end