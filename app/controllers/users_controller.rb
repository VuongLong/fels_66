class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @feed_activities = @user.activities.recent.paginate page: params[:page],
      per_page: Settings.per_page
    @results = Result.results_by_user(@user.lessons.pluck(:id))
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params 
    if @user.save
      log_in @user
      flash[:success] = t "static_pages.welcome" 
      redirect_to @user
    else
      render "new"
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update.success"
      redirect_to @user
    else
      flash[:danger] = t "update.fail"
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :picture
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "update.danger"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id] 
    redirect_to root_url unless current_user? @user
  end

  def set_user
    @user = User.find params[:id]
  end  
end
