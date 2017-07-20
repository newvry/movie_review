class MoviesController < ApplicationController

  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = current_user.movies.build
  end

  def create 
    @movie = current_user.movies.build(params_movie)
    if @movie.save
      redirect_to movies_path, notice: "電影資料新增成功！！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(params_movie)
      redirect_to movie_path(@movie), notice: "電影資料更新成功！！"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "電影資料已刪除！！"
  end


  private

  def find_movie
    @movie = Movie.find(params[:id])
  end
  
  def params_movie
    params.require(:movie).permit( :title, :description, :movie_length, :director, :rating, :image)
  end

end
