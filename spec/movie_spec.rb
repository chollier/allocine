require 'helper'

describe "Allocine Movie (Sixième Sens - 22092)" do
  
  before(:all) { @movie = Allocine::Movie.new('22092') }
  
  it 'should have a title' do
    @movie.title.should == "Sixième Sens"
  end
  
  it 'should have a synopsis' do
    @movie.synopsis.should == "Cole Sear, garconnet de huit ans est hanté par un terrible secret. Son imaginaire est visité par des esprits menaçants. Trop jeune pour comprendre le pourquoi de ces apparitions et traumatisé par ces pouvoirs paranormaux, Cole s'enferme dans une peur maladive et ne veut reveler à personne la cause de son enfermement, à l'exception d'un psychologue pour enfants. La recherche d'une explication rationnelle guidera l'enfant et le thérapeute vers une vérité foudroyante et inexplicable."
  end
  
  it 'should have an original title' do
    @movie.original_title.should == "The Sixth Sense"
  end
  
  it 'should have a nationality' do
    @movie.nat.should == "américain"
  end
  
  it 'should have a picture' do
    @movie.image.should_not be nil
  end
  
  it 'should have a genre' do
    @movie.genres.should == "Fantastique,Drame,Thriller"
  end
  
  it 'should have a director' do
    @movie.directors.should == "M. Night Shyamalan"
  end
  
  it 'should have a duration' do
    @movie.duree.should == "1h47"
  end
  
  it 'should have actors' do
    @movie.actors.should == "Bruce Willis, Haley Joel Osment, Toni Collette"
  end
  
  it 'should have an out date' do
    @movie.out_date.should == "5 janvier 2000"
  end
  
  it 'should have a trailer' do
    @movie.trailer.should == "18650495"
  end
  
  it 'should have a press rating' do
    @movie.press_rate.should == "3,2"
  end
  
  it 'should have a production date' do
    @movie.production_date.should == "1999"
  end
  
end