  class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :require_category_id
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def create
    @word = Word.new word_params
    if @word.save
      flash.now[:success] = t("admin.create_successfully")
    else
      flash.now[:failed] = t("admin.create_fail")
    end  
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "admin.update_successfully"
    else
      flash[:danger] = t "admin.update_fail"
    end
    redirect_to admin_words_path
  end
  
  def destroy
    if @word.destroy
      flash.now[:success] = t("admin.destroy_successfully")
    else
      flash.now[:failed] = t("admin.destroy_fail")
    end
  end

  private
  def word_params
    params.require(:word).permit :alphabet, :category_id,
      answers_attributes: [:id, :ans, :status, :_destroy]
  end

  def set_word
    @word = Word.find params[:id]
  end

  def require_category_id
    unless !session[:category_id].nil?
      flash[:danger] = t "admin.word.need_category_id"
      redirect_to admin_categories_path
    end
  end
end
