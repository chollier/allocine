module Allocine
class Show
  attr_accessor :title, :created_by, :producters, :nat, :genres, :duree, :original_title, :actors, :synopsis, :image
  
  def self.find(search)
    search.gsub!(' ', '+')
    str = Allocine::Web.new(SHOW_SEARCH_URL % search).data
    shows = {}
    while str =~ /<a href='\/series\/ficheserie_gen_cserie=(\d+).html'>(.*?)<\/a>/mi
      id, name = $1, $2
      unless name =~ /<img(.*?)/
        str.gsub!("<a href=\'/series/ficheserie_gen_cserie=#{id}.html\'>#{name}</a>", "")
        name.gsub!(/<(.+?)>/,'')
        name.strip!
        shows[id] = name
      else
        str.gsub!("<a href=\'/series/ficheserie_gen_cserie=#{id}.html\'>#{name}</a>", "")
      end
    end
    
    shows
  end
  
  def self.lucky_find(search)
    results = find(search)
    new(results.first)
  end
  
  def initialize(id, debug=false)
    #TODO : New Regex for new version.    
    regexps = {
      :title => '<title>(.*?)<\/title>',
      :created_by => 'Créée par (.*?)</span>', 
      :nat => 'Série.*?<a href=\'/film/tous/pays-[0-9]+/\'>(.*?)<\/a>\.', 
      :genres => 'Genre.*<a href=\'/series/toutes/genre-[0-9]+/\'>(.*?)<\/a>.',
      :duree => 'Format :(.*?)</p>',
      :original_title => 'Titre original : <span .*?><em>(.*?)<\/em><\/span>',
      :actors => 'Avec : (.*?)&nbsp;&nbsp;',
      :synopsis => '<p class="">.*?<span class="bold">Synopsis :</span>(.*?)</p>',
      :image => '<div class="poster"><em class="imagecontainer"><a .*?><img src=\'(.*?)\'alt=".*?"title=".*?"\/><img .*?><\/a><\/em>',
    }
    data = Allocine::Web.new(SHOW_DETAIL_URL % id).data.gsub(/\r|\n|\t/,"")
    regexps.each do |reg|
      print "#{reg[0]}: " if debug
      r = data.scan Regexp.new(reg[1], Regexp::MULTILINE)
      r = r.first.to_s.strip
      r.gsub!(' - AlloCiné', '')
      r.gsub!(/<.*?>/, '')
      self.instance_variable_set("@#{reg[0]}", r)
      print "#{r}\n" if debug
    end
  end
end
end