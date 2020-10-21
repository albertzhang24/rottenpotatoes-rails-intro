class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings()
    @title_classes = ""
    @rd_classes = ""
    @movies = Movie.all
    redir_flag = false
    

    if params.has_key?(:sort)
      session[:sort] = params[:sort]
    elsif session.has_key?(:sort)
      redir_flag = true 
      params[:sort] = session[:sort]
    end 
    
    if params.has_key?(:ratings)
      session[:ratings] = params[:ratings]
    elsif session.has_key?(:ratings)
      redir_flag = true 
      params[:ratings] = session[:ratings]
    end 
    
    
    if redir_flag 
      redirect_to movies_path(params)
    end 
      
    ratings_list = []
#     byebug
    if params.has_key?(:ratings)
      params[:ratings].each do | rating, val |
        ratings_list.append(rating)
      end 
      @ratings_to_show = ratings_list
      @movies = Movie.with_ratings(@ratings_to_show)
    else 
      @ratings_to_show = Movie.all_ratings()
      @movies = Movie.all
    end
    
    # byebug
    if params.has_key?(:sort)
      if params[:sort] == "title" 
        @title_classes, @movies = Movie.sort_title()
      else
        @rd_classes, @movies = Movie.sort_rd()
      end 
    end 
#     return @movies
#     @movies = Movie.with_ratings(@ratings_to_show)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
