class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :find_movie_and_check_favorite, only: [:new, :create]
  def new

    @review = Review.new
  end

  def create


    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end




def find_movie_and_check_favorite
  @movie = Movie.find(params[:movie_id])
  if !current_user.is_member_of?(@movie)
    redirect_to movie_path(@movie), alert: "You have no permission!"
  end
end
