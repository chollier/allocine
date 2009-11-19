module Allocine
class Movie
  attr_accessor :title, :directors, :trailer, :press_rate, :nat, :genres, :out_date, :duree, :production_date, :original_title, :actors, :synopsis, :image, :interdit
  
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
  
  def initialize(id, debug=false)
    regexps = {
      :title => '<div class="titlebar"><h1>(.*?)<\/h1>',
      :directors => 'Réalisé par <span .*?><a .*?>(.*?)<\/a><\/span>',
      :nat => 'Long-métrage(.*?)\.',
      :genres => 'Genre : (.*?)<br\/>',
      :out_date => 'Date de sortie cinéma : <span .*?><a .*?>(.*?)<\/a><\/span>',
      :duree => 'Durée :(.*?) min',
      :production_date => 'Année de production : <a .*?>(.*?)<\/a><br \/>',
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