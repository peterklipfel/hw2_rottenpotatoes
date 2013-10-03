class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session.merge! params # this will store controller, action, etc. info, but normally this would be encrypted server side, so we shouldn't care
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @movies = Movie.filter_by_ratings(session[:ratings].keys || @all_ratings)
                   .sort_with_params(session[:column]||'title', session[:sort]||'asc')
    @title_css_class = session[:column]=='title' ? 'hilite' : ''
    @release_date_css_class = session[:column]=='release_date' ? 'hilite' : ''
    logger.info { "  session: "+session.inspect }
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
