class ReviewsController < ApplicationController

  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :find_movie
  before_action :authenticate_user!

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params_review)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id
    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(params_review)
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def params_review
    params.require(:review).permit(:rating, :comment)
  end

end
