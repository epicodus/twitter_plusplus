class UsersController < ApplicationController

  def follow
    user_to_follow = User.find(params[:id])
    current_user.follow!(user_to_follow)

    respond_to :js
  end

  def unfollow
    user_to_unfollow = User.find(params[:id])
    current_user.unfollow!(user_to_unfollow)

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
