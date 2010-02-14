require File.expand_path(File.dirname(__FILE__) + '/../allocine.rb')
require 'sinatra/base'
require 'haml'

module Allocine
  class SinatraApp < Sinatra::Base
    set :app_file, __FILE__
    set :views, Proc.new { File.join(root, "sinatra") }
    
    get '/' do
      headers 'Content-Type' => 'text/html; charset=utf-8'
      unless params[:q] && !params[:q].empty?
        @title = "Allocine"
        @hide_headers = true
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
      headers 'Content-Type' => 'text/html; charset=utf-8'
      @movie = Allocine::Movie.new(params[:id])
      @title = @movie.title
      haml :movie
    end

    get '/show/:id' do
      headers 'Content-Type' => 'text/html; charset=utf-8'
      @show = Allocine::Show.new(params[:id])
      @title = @show.title
      haml :show
    end

    get '/main.css' do
      headers 'Content-Type' => 'text/css; charset=utf-8'
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
  
  end
end