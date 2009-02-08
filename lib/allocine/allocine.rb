module Allocine
  
  # Make a search on movies
  def self.find_movie(search)
    Allocine::Movie.find(search)
  end
  
  # Make a search on shows
  def self.find_show(search)
    Allocine::Show.find(search)
  end
  
  # Returns the first result
  def self.lucky_movie(search)
    Allocine::Movie.lucky_find(search)
  end
  
  def self.lucky_show(search)
    Allocine::Show.lucky_find(search)
  end
end