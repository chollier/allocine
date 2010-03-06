module Allocine
  class Venue
    attr_accessor :id, :name, :adress, :movies
    
    
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
      data = Allocine::Web.new(VENUE_SEARCH_URL % search).data.gsub(/\r|\n|\t|\s{2,}/,"")
      venues = Array.new
      
      while data =~ /<a href='\/seance\/salle_gen_csalle=(\w+).html'>(.*?)<\/a>/mi
        id, name = $1, $2
        data.gsub!("<a href='/seance/salle_gen_csalle=#{id}.html'>", "")
        name.gsub!(/<(.+?)>/,'')
        venues << [id, name]
      end
      
      return venues
    end
    
    def self.lucky_find(search)
      results = find(search)
      new(results.first)
    end
    
    def initialize(id, debug=false)
      self.id = id
      regexps = {
        :name => '<div class="titlebar"><h1>(.*?)<\/h1>',
        :adress => '<span class="bold">Adresse : <\/span>(.*?)<br \/>'
      }
      data = Allocine::Web.new(VENUE_DETAIL_URL % id).data.gsub(/\r|\n|\t/,"")
      regexps.each do |reg|
        print "#{reg[0]}: " if debug
        r = data.scan Regexp.new(reg[1], Regexp::MULTILINE)
        r = r.first.to_s.strip
        r.gsub!(/<.*?>/, '')
        r.strip!
        self.instance_variable_set("@#{reg[0]}", r)
        print "#{r}\n" if debug
      end
      self.movies = Array.new
      
      while data =~ /<a href='#movie(\d+)'>/mi
        self.movies << Allocine::Movie.new($1)
        data.gsub!("<a href='#movie#{$1}'>", "")
      end
      
      
    end
    
  end
end