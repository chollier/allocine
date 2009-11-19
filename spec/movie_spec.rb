require 'helper'

describe "Allocine Movie (Star Trek - 4854)" do
  
  before(:each) { @movie = Allocine::Movie.new('4854') }
  
  it 'should have a title' do
    @movie.title.should == "Star Trek : Premier contact"
  end
  
  it 'should have a synopsis' do
    @movie.synopsis.should == "De m\303\251chants extraterrestres, les Borgs, complotent contre les habitants de la Terre. Ils mettent au point une machination diabolique pour d\303\251truire l'humanit\303\251."
  end
  
  it 'should have an original title' do
    @movie.original_title.should == "Star Trek: First Contact"
  end
  
  it 'should have a nationality' do
    @movie.nat.should == "am\303\251ricain"
  end
  
  it 'should have a picture' do
    @movie.image.should_not be nil
  end
  
  it 'should have a genre' do
    @movie.genres.should == "Science fiction"
  end
  
  it 'should have a director' do
    @movie.directors.should == "Jonathan Frakes"
  end
  
  it 'should have a duration' do
    @movie.duree.should == "1h52"
  end
  
  it 'should have actors' do
    @movie.actors.should == "Jonathan Frakes, Patrick Stewart, Brent Spiner"
  end
  
  it 'should have an out date' do
    @movie.out_date.should == "5 mars 1997"
  end
  
  it 'should have a production date' do
    @movie.production_date.should == "1996"
  end
  
end