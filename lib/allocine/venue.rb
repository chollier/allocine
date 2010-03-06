module Allocine
  class Venue
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
  end
end