require 'helper'

describe "Allocine Show (Enterprise - 109)" do
  
  before(:all) { @show = Allocine::Show.new('109') }
  
  it 'should have a title' do
    @show.title.should == "Enterprise"
  end
  
  it 'should have a genre' do
    @show.genres.should == "Fantastique"
  end
  
  it 'should have an image' do
    @show.image.should == "http://images.allocine.fr/r_160_214/b_1_cfd7e1/medias/nmedia/18/35/64/59/18415355.jpg"
  end
  
  it 'should have a creator' do
    @show.created_by.should == "Brannon Braga, Rick Berman"
  end
  
  it 'should have actors' do
    @show.actors.should == "Dominic Keating, Scott Bakula, John Billingsley"
  end
  
  it 'should have a nationality' do
    @show.nat.should == "am\303\251ricaine"
  end
  
  it 'should have a synopsis' do
    @show.synopsis.should == "Le premier vaisseau terrien Enterprise, dirig\303\251 par le capitaine Jonathan Archer, part \303\240 la d\303\251couverte de mondes nouveaux, de nouvelles formes de vie et de civilisations diff\303\251rentes.Note : L'histoire se d\303\251roule 100 ans avant les aventures du capitaine Kirk dans la s\303\251rie originale Star Trek."
  end
  
  it 'should have a duree' do
    @show.duree.should == "42mn" # \o/
  end
end
