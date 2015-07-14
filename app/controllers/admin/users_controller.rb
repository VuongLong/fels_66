class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def update
    if @user.update_attributes user_params
      flash.now[:success] = t "admin.update_successfully"
    else
      flash.now[:danger] = t "admin.update_fail"
    end
  end

  def destroy
    if @user.destroy
      flash.now[:success] = t("admin.destroy_successfully")
    else
      flash.now[:failed] = t("admin.destroy_fail")
    end
  end

  private
  def user_params
    params.require(:user).permit :admin
  end

  def set_user
    @user = User.find params[:id]
  end
end
