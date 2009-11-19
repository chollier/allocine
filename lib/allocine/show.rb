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
      :created_by => '<h4>Série créée par <a .*?>(.*?)</a>', 
      :producters => '<h4>Producteurs : (.*?)</h4>', 
      :nat => '<span style=\'font-weight:bold\'>Nationalité</span> : (.*?)</h5>', 
      :genres => '<span style=\'font-weight:bold\'>Genre</span> : (.*?)&nbsp;&nbsp;', 
      :duree => '<span style=\'font-weight:bold\'>Format</span> : (.+?).&nbsp;', 
      :original_title => '<h4><b>Titre original : </b></h4><h4 style="color:#D20000"><b>(.*?)</b></h4>',
      :actors => '<h4>Avec : (.*?)&nbsp;&nbsp;', 
      :synopsis => '<h5><span style=\'font-weight:bold\'>Synopsis</span>&nbsp;&nbsp;&nbsp;.*?<br />(.*?)</h5>',
      :image => '<td><div id=\'divM\' .*?><img src=\'(.*?)\' style=\'border:1px solid black;.*?>',
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