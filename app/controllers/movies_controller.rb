class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_movie_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page =>5)
  end

  def edit

  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end

  end



  def update


    if @movie.update(movie_params)
      redirect_to movies_path, notice: "Update Success!"
    else
      render :edit
    end
  end

  def destroy

    @movie.destroy
    redirect_to movies_path, alert: "Movie Deleted!"
  end


  def favorite
   @movie = Movie.find(params[:id])

    if !current_user.is_member_of?(@movie)
      current_user.favorite!(@movie)
      flash[:notice] = "收藏成功！"
    else
      flash[:warning] = "你已经收藏过了！"
    end

    redirect_to movie_path(@movie)
  end

  def unfavorite
    @movie = Movie.find(params[:id])

    if current_user.is_member_of?(@movie)
      current_user.unfavorite!(@movie)
      flash[:alert] = "已退出收藏！"
    else
      flash[:warning] = "你没收藏这个电影，怎么退订 XD"
    end

    redirect_to movie_path(@movie)
  end



  private

  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "You have no permission!"
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
