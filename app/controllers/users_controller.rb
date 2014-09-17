class UsersController < ApplicationController

  def follow
    @user = User.find(params[:id])
    current_user.follow!(@user)

    respond_to :js
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow!(@user)

    respond_to :js
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    @search_term = params[:search_term]
    @users = User.basic_search(@search_term)
  end
  

end
