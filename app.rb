require 'rubygems'
require 'sinatra'
gem 'allocine'
require 'allocine'

get '/' do
  header 'Content-Type' => 'text/html; charset=utf-8'
  unless params[:q] && !params[:q].empty?
    @title = "Allocine"
    haml :index
  else
    @title = "Allocine &mdash; Recherche '" + params[:q] + "'"
    @script = "<script>
      $(document).ready(function(){
        $('#movie_search').load('/parts/movie/#{params[:q].gsub(/\W/, '+')}');
        $('#show_search').load('/parts/show/#{params[:q].gsub(/\W/, '+')}');
      });
      </script>"
    haml :search
  end
end

get '/movie/:id' do
  header 'Content-Type' => 'text/html; charset=utf-8'
  @movie = Allocine::Movie.new(params[:id])
  @title = @movie.title
  haml :movie
end

get '/main.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

get '/parts/movie/:search' do
  @results = Allocine::Movie.find(params[:search])
  @type = "movie"
  if @results.empty?
    "<p>Aucuns films ne correspondent à votre recherche."
  else
    haml :results, :layout => false
  end
end

get '/parts/show/:search' do
  @results = Allocine::Show.find(params[:search])
  @type = "show"
  if @results.empty?
    "<p>Aucunes séries ne correspondent à votre recherche."
  else
    haml :results, :layout => false
  end
end

use_in_file_templates!

__END__
@@ layout
!!! strict
%html
  %head
    %title= @title
    %link{:rel => 'stylesheet', :href => '/main.css', :type => 'text/css'}
    %script{:type => 'text/javascript', :src => 'http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js'}
    = @script if @script
  %body
    #container
      #head
        %h1= @title
      #body
        = yield
      #footer
        %a{:href => 'http://github.com/webs/allocine'} allocine
        on
        %a{:href => 'http://github.com/webs/allocine/tree/sinatra'} sinatra

@@ index
%h2
  Chercher sur Allocine
  %br
  %br
  %form{:action=>'/', :method=>'get'}
    %input{:id=>'q', :name=>'q', :size=>'30', :type=>'text', :placeholder=>'Star Trek'}
    %button{:type=>'submit'} OK

@@ search
%h3 Films
%div#movie_search
  Chargement des données en cours...
%h3 Séries
%div#show_search
  Chargement des données en cours...

@@ results
%ul
  - @results.each do |result|
    %li
      %a{:href=>"/#{@type}/#{result[0]}"}= result[1]

@@ movie
- if @movie.image
  %span.picture
    %img{:src => @movie.image}

- if @movie.directors
  %strong Producteurs:
  = @movie.directors
  %br
- if @movie.nat
  Film
  = @movie.nat
  %br
- if @movie.genres
  %strong Genres:
  = @movie.genres
  %br
- if @movie.out_date
  %strong Date de sortie
  = @movie.out_date
  %br
- if @movie.duree
  %strong Durée
  = @movie.duree
  %br
- if @movie.production_date
  %strong Date de production
  = @movie.production_date
  %br
- if @movie.original_title
  %strong Titre original
  = @movie.original_title
  %br
- if @movie.actors
  %strong Acteurs
  = @movie.actors
  %br
- if @movie.synopsis
  %p= @movie.synopsis
@@ stylesheet
html
  :color #000
  :font-family Helvetica Neue, Helvetica, Arial, sans-serif
  :padding 0em
  :margin 0em


body
  :line-height 1.4em
  :margin 0px
  :padding 0px
  :font-size .9em

a
  :color #000099

a:hover
  :color #000099
  :text-decoration none

#container
  :width 755px
  :margin 0 auto
  :padding 0px
  :text-align left
  :position relative

#head
  :padding 10px
  :padding-top 25px
  :background-color #202020
  :opacity 0.98
  :width 755px
  :color #FFF

#body
  :color #000
  :padding-top 10px
  :padding-bottom 10px

#footer
  :text-align center
  :border-top 1px solid black
  :padding 1px
  :color grey
  :font-size 12px

h2
  :text-align center

input
  :font-size 25px
  :text-align center

.picture 
  :float left
  :padding-right 5px