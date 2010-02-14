module Allocine
class Movie
  attr_accessor :id, :title, :directors, :trailer, :press_rate, :nat, :genres, :out_date, :duree, :production_date, :original_title, :actors, :synopsis, :image, :interdit
  
  
  def self.find(search)
    search = ActiveSupport::Multibyte.proxy_class.new(search.to_s).mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.
      downcase.
      gsub(/[\W]/u, ' ').
      gsub(/\s[a-z]{1}\s/, ' ').
      strip.
      gsub(/-\z/u, '').
      gsub(' ', '+').
      gsub('2nd', '2').
      to_s
    data = Allocine::Web.new(MOVIE_SEARCH_URL % search).data.gsub(/\r|\n|\t|\s{2,}/,"")
    movies = Array.new
    while data =~ /<a href='\/film\/fichefilm_gen_cfilm=(\d+).html'><imgsrc='.*?'alt='(.*?)' \/><\/a>/i
      id, name = $1, $2
      data.gsub!("<a href='/film/fichefilm_gen_cfilm=#{id}.html'>", "")
      name.gsub!(/<(.+?)>/,'')
      movies << [id, name]
    end
    movies = searchGoogle(search, movies.collect{|m| m[0]}) + movies
    
    return movies
  end
  
  def self.searchGoogle(search, movies)
    data = Allocine::Web.new("http://www.google.fr/search?hl=fr&q=site:allocine.fr+#{search}").data #.gsub(/\r|\n|\t/,"")
    matches = Array.new
    data.scan(/fichefilm_gen_cfilm=([0-9]*).html/) do |m| 
      matches << [m.first, "#{search} - Found by Google"] unless movies.include? m.first
    end
    return matches.uniq
  end
  
  def self.lucky_find(search)
    results = find(search)
    new(results.first)
  end
  
  def press_reviews
    data = Allocine::Web.new(MOVIE_PRESS_URL % self.id).data.gsub(/\r|\n|\t/,"")
    reviews = Array.new
    
    while data =~ /<div class="rubric"><div class="titlebar vmargin20t novmarginb"><a id="pressreview(.*?)" class="anchor"><\/a>(.*?)<\/p><\/div><div class="rubric">/i
      pressreviewid, content = $1, $2
      data.gsub!(/<a id="pressreview#{pressreviewid}" class="anchor">/, "")
      content =~ /<h2><a href="\/critique\/fichepresse_gen_cpresse=(.*?).html">(.*?)<\/a><\/h2><span><img.*?stareval n([0-9]{1}?)0 on4.*?\/><\/span><\/div><p class="lighten">(.*?)<\/p><p>(.*?)<\/p>/
      # 1 : ID, 2 : Journal, 3 : Note, 4 : Auteur, 5 : Critique
      reviews << [$1, $2, $3, $4, $5]  unless $2.nil? || $3.nil?
    end
    
    reviews
  end
  
  def initialize(id, debug=false)
    self.id = id
    regexps = {
      :title => '<div class="titlebar"><h1>(.*?)<\/h1>',
      :directors => 'Réalisé par <span .*?><a .*?>(.*?)<\/a><\/span>',
      :nat => 'Long-métrage(.*?)\.',
      :genres => 'Genre : (.*?)<br\/>',
      :out_date => 'Date de sortie cinéma : <span .*?><a .*?>(.*?)<\/a><\/span>',
      :duree => 'Durée :(.*?) min',
      :production_date => 'Année de production.*?<a .*?>(.*?)<\/a>.*?<br \/>',
      :original_title => 'Titre original : <span .*?><em>(.*?)<\/em><\/span>',
      :actors => 'Avec (.*?), <a class=',
      :synopsis => '<p><span class="bold">Synopsis : </span>(.*?)</p>',
      :image => '<div class="poster"><em class="imagecontainer"><a .*?><img src=\'(.*?)\'alt=".*?"title=".*?"\/><img .*?><\/a><\/em>',
      :press_rate => '<p class="withstars"><a href=\'/film/revuedepresse_gen_cfilm=[0-9]*?.html\'><img .*? /></a><span class="moreinfo">\((.*?)\)</span></p></div>',
      :trailer => "<li class=\"\"><a href=\"\/video\/player_gen_cmedia=(.*?)&cfilm=#{id}\.html\">Bandes-annonces<\/a><\/li>"
    }
    data = Allocine::Web.new(MOVIE_DETAIL_URL % id).data.gsub(/\r|\n|\t/,"")
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