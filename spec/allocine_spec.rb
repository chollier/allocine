require 'helper'

describe "Allocine" do
  it "find movie" do
    Allocine.find_movie('Plan 9').size.should == 2
  end
  
  it "find show" do
    Allocine.find_show('XFiles').should == {"182"=>"X-Files : Aux fronti\303\250res du r\303\251el", "223"=>"Lost"}
  end
  
  it "lucky movie" do
    Allocine.lucky_movie('Les pirates de la Silicon Valley').is_a?(Allocine::Movie).should == true
  end
  
  it "lucky show" do
    Allocine.lucky_show('Stargate').is_a?(Allocine::Show).should == true
  end
end