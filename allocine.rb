require 'rubygems'
require 'sinatra'
require '../allocine/lib/allocine'

#configure do
  #set :haml, :format => :html5
#end

get '/' do
  @title = "Allocine"
  haml :index
end

get '/main.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

use_in_file_templates!

__END__
@@ layout
!!! strict
%html
  %head
    %title= @title
    %link{:rel => 'stylesheet', :href => '/main.css', :type => 'text/css'}
  %body
    #container
      #head
        %h1 Allocine
      #body
        = yield
        
@@ stylesheet
html
  :color #FFF
  :font-family Helvetica Neue, Helvetica, Arial, sans-serif
  :padding 0em


body
  :margin-left 2.6em
  :margin-top 1.8em
  :margin-bottom 1em
  :margin-right 1em
  :line-height 1.4em
  :font-size .9em


#container
  :width 755px
  :margin 0 auto
  :padding 15px 0
  :text-align left
  :position relative


#head
  :top 0px
  :position fixed
  :padding 10px
  :padding-top 25px
  :background-color #202020
  :opacity 0.98
  :width 755px
